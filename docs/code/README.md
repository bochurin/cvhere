# Coding Decisions

This folder contains implementation-specific decisions made during development.

## Organization

**Implementation Decisions:**
- `backend-framework.md` - Backend framework decision (Fastify)
- `database-approach.md` - Database access layer decision (Prisma ORM)
- `frontend-config.md` - Pipeline-driven configuration approach
- `terraform-infrastructure.md` - Infrastructure as Code implementation
- `package-management.md` - Package manager and monorepo structure
- `repository-structure.md` - Monorepo organization
- `line-endings.md` - Git line ending configuration
- `todo-tree-config.md` - TODO Tree extension configuration

**Development Tracking:**
- `DEVELOPMENT-LOG.md` - Progress tracking and completed tasks
- `feature-logs/` - Feature-specific implementation logs and plans
  - `basic-app.md` - Phase 2: Frontend-backend integration
  - `basic-auth.md` - Authentication system (cancelled)
  - `ci-cd-pipeline.md` - Phase 3: CI/CD and infrastructure

## Decision Format

Each file should include:
- **Date**: When decision was made
- **Context**: What problem we're solving
- **Options**: Alternatives considered
- **Decision**: What we chose and why
- **Implementation**: Code approach
- **Changes**: History of modifications

## Example Entry

```markdown
### 2024-01-15 - JWT Token Storage
**Context**: Where to store JWT tokens in frontend
**Options**: localStorage, sessionStorage, httpOnly cookies
**Decision**: localStorage for MVP simplicity
**Reason**: Easier development, acceptable for bootstrap phase
**Implementation**: Store in localStorage, check on app init
```