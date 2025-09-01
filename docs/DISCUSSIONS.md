# CVHere - Discussion Log

Chronological log of discussions, ideas, questions and decisions during development.

## Entry Format

**Date - Discussion Topic**
- **Question**: What was discussed
- **Key Points**: Main arguments and alternatives
- **Outcome**: Decision made or question deferred
- **Actions**: What documentation was updated

---

## 2024-12-19 - Database approach discussion
- **Question**: Which approach to use for PostgreSQL - raw SQL, Knex or ORM?
- **Key Points**: Discussed Raw SQL (control), Knex (flexibility), Prisma (type safety)
- **Outcome**: Chose Prisma ORM for type safety and developer experience
- **Actions**: Created database-approach.md, updated DECISIONS.md

## 2024-12-19 - Backend framework discussion
- **Question**: Express vs Fastify vs NestJS for API server
- **Key Points**: Importance of TypeScript support, performance, setup simplicity
- **Outcome**: Changed decision from Express to Fastify for better TypeScript support
- **Actions**: Created backend-framework.md, updated ARCHITECTURE.md and package.json

## 2024-12-19 - Documentation structure optimization
- **Question**: How to optimize documentation - all decisions in one file or separate?
- **Key Points**: Readability vs maintainability, avoiding duplication
- **Outcome**: DECISIONS.md as brief overview + detailed files in docs/code/
- **Actions**: Restructured documentation, created DISCUSSIONS.md

## 2024-12-19 - Need for database/ folder
- **Question**: Use separate database/ folder or follow Prisma conventions?
- **Key Points**: Prisma has its own conventions (prisma/ folder)
- **Outcome**: Removed database/, using prisma/ for schema and migrations
- **Actions**: Moved schema.prisma, removed database/README.md

## 2024-12-19 - Email service selection
- **Question**: Which email service for authentication emails - Gmail, SendGrid, AWS SES, or Mailgun?
- **Key Points**: Cost analysis for 10K users, deliverability concerns, development vs production needs
- **Outcome**: Chose AWS SES for cost efficiency ($15/year vs $180+ alternatives) with replaceable module design
- **Actions**: Updated DECISIONS.md, will implement replaceable email service interface

## 2024-12-19 - Email service failover strategy
- **Question**: How to handle email service limits and availability issues?
- **Key Points**: AWS SES has daily limits, need backup for reliability, cost optimization with primary/secondary
- **Outcome**: Implement dual email service with automatic failover - AWS SES primary, SendGrid secondary
- **Actions**: Will implement failover logic with limit tracking and availability detection

## 2024-12-19 - Runtime configuration without deployment
- **Question**: How to configure app parameters (email settings, rate limits) without redeployment?
- **Key Points**: Need runtime updates for email service switching, API rate limits; avoid mixing with user data
- **Outcome**: Configuration file + file watching approach - JSON config file with admin API updates
- **Actions**: Will implement config file system with file monitoring and admin API

## 2024-12-19 - Configuration file format: JSON vs JSON5 vs YAML
- **Question**: Which format for config files with inline comment support?
- **Key Points**: JSON5 has tooling issues, YAML widely supported, inline comments important for config
- **Outcome**: Chose YAML for config files - better comment support, widely used, good tooling
- **Actions**: Updated config system to use YAML parser, converted config file with inline comments

## 2024-12-19 - Reset to minimal foundation approach
- **Question**: Continue with complex auth implementation or start with minimal foundation?
- **Key Points**: Current auth implementation became complex, better to build incrementally from solid base
- **Outcome**: Cancel basic-auth feature, start fresh with minimal app foundation
- **Actions**: Created basic-app feature plan, will build: minimal backend → simple frontend → CI/CD → then auth