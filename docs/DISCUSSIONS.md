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