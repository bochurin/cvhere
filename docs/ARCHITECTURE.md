# CVHere - Architecture Decisions

## Tech Stack
- **Backend**: Node.js + Fastify + TypeScript *(updated 2024-12-19: changed from Express to Fastify for better TypeScript support)*
- **Frontend**: React + localStorage
- **Database**: PostgreSQL (SQL + JSONB for NoSQL)
- **Authentication**: Custom JWT + bcrypt
- **Sessions**: express-session + connect-pg-simple

## Infrastructure
- **Deployment**: EC2 + Docker + Docker Compose
- **Environments**: Development (local), Staging (staging.cvhere.net), Production (cvhere.net)
- **CI/CD**: GitHub Actions
- **Monitoring**: Basic logging + health checks
- **Cloud**: AWS with free tier optimization

## Key Principles
- **Vendor Lock-in Avoidance**: Portable stack, standard technologies
- **Privacy-First**: No personal data on server, localStorage only
- **Bootstrap Friendly**: Minimal costs, simple architecture
- **Team-Ready**: GitHub workflow for small team collaboration
- **Scalable Foundation**: Can add complexity later

## Deferred for Later
- Sentry error tracking
- Advanced graph queries
- Caching layer
- Database clustering
- Microservices architecture