# CVHere - Architecture Overview

## Current Tech Stack
- **Backend**: Node.js + Fastify + TypeScript
- **Frontend**: React + Vite + js-yaml
- **Database**: PostgreSQL + Prisma ORM (planned)
- **Configuration**: Pipeline-driven YAML configs
- **Development**: ts-node + nodemon

## Infrastructure
- **Cloud**: AWS (free tier optimized)
- **Infrastructure as Code**: Terraform
- **Compute**: EC2 t2.micro instances
- **Networking**: VPC with public subnets
- **Security**: Security Groups for HTTP/HTTPS/SSH/API
- **Environments**: Development (local), Staging, Production

## CI/CD Pipeline
- **Platform**: GitHub Actions
- **Workflows**: Backend, Frontend, Infrastructure (Terraform)
- **Environment Strategy**: develop → staging, tags → production
- **Config Injection**: Pipeline replaces config.yaml per environment
- **Triggers**: Path-based (only run when relevant files change)
- **Security**: AWS credentials via GitHub secrets

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