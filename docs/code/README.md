# Coding Decisions

This folder contains implementation-specific decisions made during development.

## Organization

**By Feature Branch:**
- `auth-system.md` - Authentication implementation decisions
- `profile-builder.md` - Profile building feature decisions
- `matching-engine.md` - Search and matching logic decisions
- `pdf-export.md` - PDF generation implementation
- `database-schema.md` - Database design and queries
- `DEVELOPMENT-LOG.md` - Progress tracking and completed tasks
- `package-management.md` - Package manager and monorepo structure decisions
- `line-endings.md` - Git line ending configuration and rationale
- `todo-tree-config.md` - TODO Tree icons and colors configuration
- `database-approach.md` - Database access layer decision (Prisma ORM)

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