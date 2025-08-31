# CVHere - Technical Decisions

Chronological log of all technical decisions with rationale and change history.

## 2024-12-19

### Backend Framework: Express → Fastify
**Decision**: Use Fastify instead of Express for API server
**Rationale**: Better TypeScript support, performance, and Prisma integration
**Details**: See [backend-framework.md](code/backend-framework.md)

### TypeScript Adoption
**Decision**: Use TypeScript for backend development
**Rationale**: Type safety with Prisma, better IDE support, compile-time error checking
**Details**: Full TypeScript setup with tsconfig.json, ts-node for development

### Email Service: AWS SES + SendGrid Failover
**Decision**: Use AWS SES primary with SendGrid secondary for automatic failover
**Rationale**: Cost optimization (AWS SES cheap) + reliability (SendGrid backup for limits/outages)
**Details**: Dual service architecture with limit tracking, automatic failover on errors/limits

### Runtime Configuration: File-based Config
**Decision**: Use configuration file + file watching for runtime settings without deployment
**Rationale**: Clean separation from user data, version controllable, no additional DB infrastructure
**Details**: JSON config file with admin API updates, file system monitoring for hot reload

### Database Access: Prisma ORM
**Decision**: Use Prisma ORM for database access
**Rationale**: Type-safe operations, excellent DX, perfect for atomic data model
**Details**: See [database-approach.md](code/database-approach.md)

### Package Management: Single root package.json
**Decision**: Use single package.json instead of workspaces
**Rationale**: Simpler for bootstrap MVP, easy to migrate later
**Details**: See [package-management.md](code/package-management.md)

### Repository Structure: Monorepo
**Decision**: Single repository with backend/frontend/shared folders
**Rationale**: Better coordination for small team, tightly coupled development
**Details**: See [repository-structure.md](code/repository-structure.md)

### Git Configuration: LF line endings
**Decision**: Use LF line endings everywhere with .gitattributes
**Rationale**: Tool compatibility, cross-platform consistency
**Details**: See [line-endings.md](code/line-endings.md)

### TODO Tree Configuration: Custom icons and colors
**Decision**: Custom icon scheme matching markdown visual style
**Rationale**: Visual consistency, better readability, professional workflow
**Details**: See [todo-tree-config.md](code/todo-tree-config.md)