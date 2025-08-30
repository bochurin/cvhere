# CVHere - Development Workflow

## Version Control
- **Repository**: GitHub with feature branches
- **Code Review**: Pull requests required for main branch
- **Team Size**: Solo start, expandable to 2-4 developers

## CI/CD Pipeline
- **Staging Deployment**: Auto-deploy on push to `develop` branch
- **Production Deployment**: Deploy only on release tags (v1.0.0, v1.1.0)
- **Testing**: Automated tests run before deployment
- **Monitoring**: Basic health checks and log monitoring
- **Rollback**: Deploy previous release tag for quick revert

## Testing Strategy
- **Framework**: Jest for backend and frontend testing
- **Approach**: Write code first, add tests after (no TDD initially)
- **Priority**: API tests, unit tests for critical paths (auth, validation)
- **Coverage**: Focus on authentication, data integrity, core business logic
- **Learning**: Gradual adoption of testing practices

## Development Environments
- **Development**: Local Docker Compose
- **Staging**: staging.cvhere.net (restricted access)
- **Production**: cvhere.net (public access)