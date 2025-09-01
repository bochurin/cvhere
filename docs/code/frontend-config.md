# Frontend Configuration Decision

## 2024-12-19 - Pipeline-Driven Configuration

**Context**: How to handle environment-specific configuration for frontend application
**Problem**: Need different backend URLs for development, staging, and production environments

**Options Considered**:
1. **Build-time environment variables** - Vite .env files, requires rebuild for changes
2. **Runtime environment-specific files** - config.development.yaml, config.staging.yaml, etc.
3. **Pipeline-driven configuration** - Single build, pipeline injects environment config

**Decision**: Pipeline-driven configuration
**Rationale**: 
- **Single build artifact**: Same build deployed to all environments
- **Pipeline controls environment**: Deployment pipeline determines configuration
- **Runtime flexibility**: Can change backend URL without frontend redeploy
- **Proper CI/CD**: Industry best practice for deployment pipelines
- **Security**: Sensitive configs not embedded in frontend bundle

**Implementation**:
- Frontend always fetches `/config.yaml`
- Development: Default config.yaml in repository
- Staging/Production: Pipeline replaces config.yaml during deployment
- YAML format with comments for maintainability
- Fallback to localhost:3001 if config loading fails

**Deployment Flow**:
```bash
# Build once
npm run build

# Deploy to staging
cp config.staging.yaml dist/config.yaml
deploy dist/ to staging

# Deploy to production  
cp config.production.yaml dist/config.yaml
deploy dist/ to production
```

**Benefits**:
- Same build artifact promotes across environments
- Configuration changes don't require frontend rebuild
- Pipeline has full control over environment-specific settings
- Reduces deployment complexity and risk
- Enables proper blue/green deployments

**Future Considerations**:
- Template-based config injection for dynamic values
- Encrypted configuration for sensitive settings
- Configuration validation in pipeline
