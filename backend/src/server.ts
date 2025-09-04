import Fastify from 'fastify';

const fastify = Fastify({
  logger: true
});

// Enable CORS for frontend
fastify.register(require('@fastify/cors'), {
  origin: true  // Allow all origins for simplicity
});

// Health check endpoint
fastify.get('/health', async () => {
  return {
    status: 'ok',
    timestamp: new Date().toISOString(),
    environment: process.env.NODE_ENV || 'development'
  };
});

const start = async () => {
  try {
    await fastify.listen({ port: 3001, host: '0.0.0.0' });
    console.log('Server running on port 3001');
  } catch (err) {
    fastify.log.error(err);
    process.exit(1);
  }
};

start();