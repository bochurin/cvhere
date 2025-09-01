# CVHere - Technical Decisions Index

Master index of all technical decisions with links to detailed documentation.

## Backend Decisions
- **[Framework](backend/framework.md)** - Fastify choice and TypeScript setup
- **[Database](backend/database.md)** - Prisma ORM for type-safe database access

## Frontend Decisions  
- **[Configuration](frontend/configuration.md)** - Pipeline-driven environment config

## Infrastructure Decisions
- **[Terraform](infrastructure/terraform.md)** - Infrastructure as Code with AWS
- **[CI/CD](infrastructure/cicd.md)** - GitHub Actions workflows (planned)
- **[Environments](infrastructure/environments.md)** - Staging/production setup (planned)

## Process Decisions
- **[Package Management](process/package-management.md)** - npm workspaces structure
- **[Repository Structure](process/repository-structure.md)** - Monorepo organization
- **[Line Endings](process/line-endings.md)** - Git configuration for cross-platform
- **[TODO Tree](process/todo-tree.md)** - Development workflow tooling
- **[Documentation Strategy](process/documentation-strategy.md)** - Selective merging approach

## Decision Timeline

### 2024-12-19
1. Backend Framework: Fastify
2. TypeScript Adoption
3. Database Access: Prisma ORM
4. Package Management: npm workspaces
5. Repository Structure: Monorepo
6. Git Configuration: LF line endings
7. Runtime Configuration: YAML file-based
8. Email Service: AWS SES + SendGrid failover
9. Development Approach: Minimal foundation first
10. Frontend Configuration: Pipeline-driven
11. Infrastructure: Terraform IaC
12. CI/CD Pipeline: GitHub Actions
13. Documentation Strategy: Selective merging
14. TODO Tree Configuration: Custom icons

*See [DISCUSSIONS.md](DISCUSSIONS.md) for discussion history and rationale.*