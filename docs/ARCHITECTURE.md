# CVHere - Architecture Overview

## Current Tech Stack
- **Backend**: Node.js + Fastify + TypeScript
- **Frontend**: React + localStorage
- **Database**: PostgreSQL + Prisma ORM
- **Authentication**: JWT + bcrypt
- **Development**: Docker Compose + GitHub Actions

## Infrastructure
- **Deployment**: EC2 + Docker + Docker Compose
- **Environments**: Development (local), Staging, Production
- **CI/CD**: GitHub Actions
- **Monitoring**: Basic logging + health checks
- **Cloud**: AWS with free tier optimization

## Architecture Principles
- **Privacy-First**: Personal data in localStorage only
- **Type Safety**: TypeScript + Prisma for compile-time checks
- **Bootstrap Friendly**: Minimal costs, simple architecture
- **Scalable Foundation**: Can add complexity later

## Future Considerations
- Sentry error tracking
- Advanced graph queries
- Caching layer
- Database clustering
- Microservices architecture

*See [DECISIONS.md](DECISIONS.md) for technical decision history and rationale.*