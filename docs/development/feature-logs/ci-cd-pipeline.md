# Feature: CI/CD Pipeline

## Branch History
- **`feature/ci-cd-pipeline`** (2024-12-19) - In progress, infrastructure and workflows complete

## Latest Iteration: 2025-09-04 - Docker-Based Deployment Enhancement

**Branch**: `feature/docker-deployment` (in progress)
**Goal**: Replace manual deployment with Docker containers for reliable, consistent deployments
**Status**: In Progress - Docker setup created, testing deployment

## Feature Plan

### ✅ Phase 1: Basic Infrastructure (Completed)
- ✅ Simple Terraform configuration for AWS EC2 instances
- ✅ Default VPC usage (no custom VPC complexity)
- ✅ Basic Security Groups (HTTP, SSH, API ports)
- ✅ Staging and production tfvars files

### ✅ Phase 2: Server Automation (Completed)
- ✅ User_data script with NVM-based Node.js installation
- ✅ Automated Node.js v16.20.2 setup on server startup
- ✅ SSH key pair integration for secure access
- ✅ Manual testing verified server automation works

### ✅ Phase 3: GitHub Actions (Completed)
- ✅ Single deploy.yml workflow (simplified approach)
- ✅ Build automation for backend and frontend
- ✅ SSH-based deployment with file copying
- ✅ Service startup automation on remote server
- ✅ Manual trigger support for testing

### 🚧 Phase 4: Docker Enhancement (In Progress)
- 🕰️ **Docker Containers**: Backend/frontend Dockerfiles created
- 🕰️ **Docker Compose**: Service orchestration configuration
- 🕰️ **Infrastructure Update**: Terraform updated for Docker installation
- 🕰️ **CI/CD Integration**: Pipeline updated for container deployment
- 🕰️ **Resource Naming**: Proper naming without AWS prefixes

### 📋 Phase 5: Blue-Green Deployment (Planned)
- 📋 Container swapping strategy
- 📋 Nginx proxy for traffic switching
- 📋 Health checks before switching
- 📋 Rollback automation
- 📋 Zero-downtime deployments

## Success Criteria

- ✅ Terraform infrastructure deploys successfully to AWS
- ✅ GitHub Actions workflow triggers on push to develop and releases
- ✅ Server automation installs Node.js automatically
- ✅ SSH-based deployment working
- 🕰️ Backend builds and tests pass in pipeline
- 🕰️ Frontend builds and tests pass in pipeline
- 🕰️ Full deployment flow tested end-to-end
- 🕰️ Application running on deployed server
- 🕰️ Health checks confirm successful deployments

## Technical Decisions

- **CI/CD Platform**: GitHub Actions (repository integration, cost effective)
- **Infrastructure**: Terraform IaC with AWS (reproducible, version controlled)
- **Environment Strategy**: develop → staging, main → stable, releases → production
- **Config Injection**: Pipeline replaces config.yaml per environment
- **Path Triggers**: Only run workflows when relevant files change
- **Security**: AWS credentials via GitHub secrets
- **Deployment**: Docker containers with docker-compose orchestration
- **Monitoring**: Basic health checks and deployment notifications

## Implementation Details

### Single Deployment Pipeline (`deploy.yml`)
- **Triggers**: Push to develop branch, releases, manual trigger
- **Build**: Backend and frontend build automation
- **Infrastructure**: Terraform integration to get server IP
- **Deploy**: SSH-based file copying and service startup
- **Simple**: One workflow handles everything

### Terraform Infrastructure
- **Simple**: Single EC2 instance with default VPC
- **Automated**: User_data installs Node.js via NVM
- **Secure**: SSH key pair for deployment access
- **Cost-effective**: t2.micro instances (free tier)

### Deployment Process
1. GitHub Actions builds backend/frontend
2. Terraform provides server IP address
3. SSH copies built files to server
4. Services started via SSH commands
5. Basic logging for troubleshooting

### Environment Strategy
```
develop branch → staging environment
main branch → stable code (no deployment)
version tags/releases → production deployment
```

### Pipeline Config Injection
```yaml
# Staging
echo "backendUrl: https://api-staging.cvhere.net" > frontend/dist/config.yaml

# Production  
echo "backendUrl: https://api.cvhere.net" > frontend/dist/config.yaml
```

### GitHub Secrets Required
- `AWS_ACCESS_KEY_ID`: AWS access key for deployment
- `AWS_SECRET_ACCESS_KEY`: AWS secret key for deployment

## Current Status

**Phase**: Phase 4 Docker Enhancement 🚧
**Completed**: 
- **Infrastructure Automation**: Terraform with S3 backend, proper state management
- **GitHub Actions**: Automated build, deploy, service management
- **Docker Setup**: Dockerfiles and docker-compose created
- **Resource Naming**: Proper naming conventions implemented
- **Environment Configuration**: Dynamic config injection working
**In Progress**: Docker deployment integration and testing
**Outcome**: Moving from manual deployment to containerized deployment

## Cross-Feature Dependencies

**Depends on**: basic-app foundation (health endpoints for deployment verification)
**Enables**: All future features (authentication, profile builder, etc.) will use this CI/CD pipeline
**Learning**: Discovered need for proper infrastructure before complex features like authentication