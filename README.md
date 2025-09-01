# CVHere

Privacy-first CV building and searching application with atomic data model.

## 📖 Documentation

Complete project documentation is organized in the **[docs/](docs/)** folder:

### 📋 Project Overview
- **[Concept](docs/project/concept.md)** - Platform vision, features, and core concepts
- **[Architecture](docs/project/architecture.md)** - Tech stack and infrastructure overview
- **[MVP Scope](docs/project/mvp-scope.md)** - MVP features and success metrics
- **[Security](docs/project/security.md)** - Security measures and privacy
- **[Workflow](docs/project/workflow.md)** - Git workflow and CI/CD process

### 🔧 Development
- **[Progress Log](docs/development/progress-log.md)** - Development phases and current status
- **[Decisions](docs/development/decisions/decisions.md)** - Technical decisions index
- **[Discussions](docs/development/decisions/discussions.md)** - Discussion log

### 🚀 Features
- **[Basic App](docs/development/feature-logs/basic-app.md)** - Foundation (completed)
- **[CI/CD Pipeline](docs/development/feature-logs/ci-cd-pipeline.md)** - Deployment (in progress)
- **[Authentication](docs/development/feature-logs/basic-auth.md)** - User auth (planned)

## 🚀 Quick Start

```bash
# Install dependencies
npm install

# Start development servers
npm run dev

# Build for production
npm run build

# Run tests
npm run test
```

## 🏗️ Development Workflow

### Discussing New Ideas
**"Discuss: [your idea/question]"**

### Feature Development
**"Feature: [feature name] - [brief description]"**

### Documentation Strategy
- **Common docs** (architecture, decisions) → merge to main
- **Feature logs** → stay in feature branches until complete
- **Automated workflow** → `npm run docs` (commits docs-only, selective merge to main)
- **Separate concerns** - decisions vs implementation

## 📁 Project Structure

```
cvhere/
├── backend/          # Node.js + Fastify API
├── frontend/         # React + Vite application  
├── terraform/        # AWS infrastructure
├── docs/            # Complete documentation
└── README.md        # This file
```

## 🎯 Current Status

**Phase 3**: CI/CD Pipeline Implementation
**Branch**: `feature/ci-cd-pipeline`
**Next**: Pipeline integration and testing

*See [Progress Log](docs/development/progress-log.md) for detailed development status.*