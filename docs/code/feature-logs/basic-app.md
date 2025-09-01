# Feature: Basic App Foundation

## 2024-12-19 - Minimal Foundation Implementation

**Branch**: `feature/basic-app`
**Goal**: Build minimal working application with health checks and CI/CD foundation

## Feature Plan

### Phase 1: Minimal Backend
- ✅ Create minimal Fastify server with TypeScript
- ✅ Add single health endpoint (/health)
- ✅ Return status, timestamp, environment in health response
- ✅ Test backend health endpoint locally

### Phase 2: Simple Frontend
- ✅ Create minimal React app with Vite
- ✅ Add health check component that calls backend
- ✅ Display environment in app title/header
- ✅ Show backend connection status (connected/disconnected)
- ✅ Test frontend-backend integration locally
- ✅ Implement pipeline-driven configuration (YAML)

### Phase 3: Infrastructure & CI/CD
<!-- TODO: Create Terraform infrastructure for AWS -->
- 🕰️ Create Terraform infrastructure for AWS (EC2, VPC, Security Groups)
<!-- TODO: Set up staging and production environments -->
- 🕰️ Set up staging and production environments with Terraform
<!-- TODO: Create GitHub Actions workflow for backend -->
- 🕰️ Create GitHub Actions workflow for backend
<!-- TODO: Create GitHub Actions workflow for frontend -->
- 🕰️ Create GitHub Actions workflow for frontend
<!-- TODO: Add Terraform deployment to pipeline -->
- 🕰️ Add Terraform deployment to pipeline
<!-- TODO: Add pipeline config injection for environments -->
- 🕰️ Add pipeline config injection for environments
<!-- TODO: Test full deployment pipeline -->
- 🕰️ Test full deployment pipeline

### Phase 4: Foundation Complete
<!-- TODO: Document deployment process -->
- 🕰️ Document deployment process
<!-- TODO: Verify health checks work in deployed environment -->
- 🕰️ Verify health checks work in deployed environment
<!-- TODO: Clean up and prepare for authentication feature -->
- 🕰️ Clean up and prepare for authentication feature

## Success Criteria

- ✅ Backend health endpoint returns proper JSON response
- ✅ Frontend successfully calls backend health endpoint
- ✅ Environment clearly displayed in frontend and browser tab
- ✅ Connection status detection works (Connected/Disconnected)
- ✅ Backend starts/stops reliably with Ctrl+C
- ✅ CORS properly configured for frontend-backend communication
- ✅ Pipeline-driven YAML configuration implemented
<!-- TODO: CI/CD pipeline builds and deploys both apps -->
- 🕰️ CI/CD pipeline builds and deploys both apps
<!-- TODO: Health checks work in staging/production -->
- 🕰️ Health checks work in staging/production
<!-- TODO: Clean foundation ready for feature development -->
- 🕰️ Clean foundation ready for feature development

## Technical Decisions

- **Backend**: Fastify + TypeScript (minimal, reliable start/stop)
- **Frontend**: React + Vite + js-yaml (fast development)
- **Configuration**: Pipeline-driven YAML configs (single build artifact)
- **Connection Detection**: 5-second health checks with 3-second timeout
- **Error Handling**: Proper fetch error handling and fallbacks
- **CORS**: @fastify/cors for frontend-backend communication
- **Environment Display**: Dynamic browser tab titles
- **CI/CD**: GitHub Actions (ready for Phase 3)
- **Deployment**: Simple approach, can enhance later

## Current Status

**Phase**: Phase 2 Complete ✅
**Completed**: 
- Minimal Fastify backend with reliable start/stop (Ctrl+C works)
- React frontend with health check component
- Connection status detection (Connected/Disconnected)
- Environment display in browser tab: "CVHere (env: development)"
- Pipeline-driven YAML configuration system
- CORS support for frontend-backend communication
- 3-second timeout and proper error handling
**Next**: Phase 3 - Basic CI/CD implementation

## Plan Confirmation

**Approach**: Start minimal, build incrementally
**Benefits**: Solid foundation, working CI/CD early, clear environment separation
**Ready to proceed step-by-step?**