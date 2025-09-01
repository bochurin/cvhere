# Repository Structure Decision

## 2024-12-19 - Monorepo Structure

**Context**: Decide between monorepo vs multi-repo for CVHere project
**Options**: 
- Monorepo: Single repository with backend/frontend/infrastructure
- Multi-repo: Separate repositories for each component

**Decision**: Monorepo approach
**Reason**: 
- Small team coordination (solo → 2-4 people)
- Tightly coupled frontend/backend
- Shared documentation and decisions
- Simpler CI/CD pipeline
- Atomic commits across components

**Implementation**:
```
cvhere/
├── backend/          # Node.js + Express API
├── frontend/         # React application
├── shared/           # Common code, types, utilities
├── database/         # Migrations, seeds, scripts
├── terraform/        # AWS infrastructure
├── docs/            # All project documentation
├── .github/         # GitHub Actions workflows
├── docker-compose.yml # Local development
└── README.md        # Project overview
```

**Folder Purposes**:
- **shared/**: TypeScript types, constants, validation schemas, utilities
- **database/**: SQL migrations, seed data, maintenance scripts

**Git Workflow**:
- Feature branches: `feature/auth-system`, `feature/profile-builder`
- Environment branches: `develop` (auto-deploy to staging), `main` (release tags to production)
- Pull requests required for all merges