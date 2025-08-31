import Fastify from 'fastify';
import { authRoutes } from './routes/auth';

const fastify = Fastify({ logger: true });

// Register routes
fastify.register(authRoutes, { prefix: '/api/auth' });

// Health check
fastify.get('/health', async () => {
  return { status: 'ok', timestamp: new Date().toISOString() };
});

const start = async () => {
  try {
    const port = parseInt(process.env.PORT || '3001');
    await fastify.listen({ port, host: '0.0.0.0' });
    console.log(`Server running on port ${port}`);
  } catch (err) {
    fastify.log.error(err);
    process.exit(1);
  }
};

start();