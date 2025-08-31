import { FastifyInstance } from 'fastify';
import { PrismaClient } from '@prisma/client';
import { hashPassword, comparePassword, generateJWT, generateToken } from '../utils/auth';
import { createEmailService } from '../services/email';

const prisma = new PrismaClient();
const emailService = createEmailService();

export async function authRoutes(fastify: FastifyInstance) {
  // Register endpoint
  fastify.post('/register', {
    schema: {
      body: {
        type: 'object',
        required: ['email', 'password'],
        properties: {
          email: { type: 'string', format: 'email' },
          password: { type: 'string', minLength: 8 }
        }
      }
    }
  }, async (request, reply) => {
    const { email, password } = request.body as { email: string; password: string };

    // Check if user already exists
    const existingUser = await prisma.user.findUnique({ where: { email } });
    if (existingUser) {
      return reply.status(400).send({ error: 'User already exists' });
    }

    // Create user with verification token
    const hashedPassword = await hashPassword(password);
    const verificationToken = generateToken();

    const user = await prisma.user.create({
      data: {
        email,
        password: hashedPassword,
        verificationToken,
        emailVerified: false
      }
    });

    // Send verification email
    await emailService.sendVerificationEmail(email, verificationToken);

    reply.status(201).send({ 
      message: 'User registered. Please check your email for verification.' 
    });
  });

  // Email verification endpoint
  fastify.get('/verify/:token', async (request, reply) => {
    const { token } = request.params as { token: string };

    const user = await prisma.user.findFirst({
      where: { verificationToken: token }
    });

    if (!user) {
      return reply.status(400).send({ error: 'Invalid verification token' });
    }

    await prisma.user.update({
      where: { id: user.id },
      data: {
        emailVerified: true,
        verificationToken: null
      }
    });

    reply.send({ message: 'Email verified successfully' });
  });

  // Login endpoint
  fastify.post('/login', {
    schema: {
      body: {
        type: 'object',
        required: ['email', 'password'],
        properties: {
          email: { type: 'string', format: 'email' },
          password: { type: 'string' }
        }
      }
    }
  }, async (request, reply) => {
    const { email, password } = request.body as { email: string; password: string };

    const user = await prisma.user.findUnique({ where: { email } });
    if (!user) {
      return reply.status(401).send({ error: 'Invalid credentials' });
    }

    if (!user.emailVerified) {
      return reply.status(401).send({ error: 'Please verify your email first' });
    }

    const isValidPassword = await comparePassword(password, user.password);
    if (!isValidPassword) {
      return reply.status(401).send({ error: 'Invalid credentials' });
    }

    const token = generateJWT(user.id);
    reply.send({ token, user: { id: user.id, email: user.email } });
  });
}