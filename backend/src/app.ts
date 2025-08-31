import Fastify from 'fastify';
import cors from '@fastify/cors';
import helmet from '@fastify/helmet';
import rateLimit from '@fastify/rate-limit';
import 'dotenv/config';

const fastify = Fastify({ logger: true });

// Register plugins
fastify.register(helmet);
fastify.register(cors);
fastify.register(rateLimit, {
  max: 100,
  timeWindow: '15 minutes'
});

// Health check route
fastify.get('/api/health', async (request, reply) => {
  return { status: 'ok', timestamp: new Date().toISOString() };
});

// Start server
const start = async () => {
  try {
    const PORT = process.env.PORT || 3001;
    await fastify.listen({ port: Number(PORT), host: 'localhost' });
    console.log(`Server running on port ${PORT}`);
  } catch (err) {
    console.error('Error starting server:', err);
    process.exit(1);
  }
};

start();