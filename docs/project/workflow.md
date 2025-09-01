# CVHere - Development Workflow

## Version Control
- **Repository**: GitHub with feature branches
- **Branch Strategy**: main (docs) → develop (integration) → feature branches
- **Code Review**: Pull requests required for develop and main branches
- **Team Size**: Solo start, expandable to 2-4 developers

## CI/CD Pipeline
- **GitHub Actions**: Automated workflows for backend, frontend, infrastructure
- **Path-based Triggers**: Only run workflows when relevant files change
- **Environment Strategy**: develop → staging, version tags → production
- **Config Injection**: Pipeline replaces config.yaml per environment
- **Infrastructure**: Terraform managed via pipeline
- **Rollback**: Deploy previous version tags for quick revert

## Deployment Flow
1. **Feature Development**: Feature branch → PR to develop
2. **Staging Deployment**: Merge to develop → auto-deploy staging
3. **Production Release**: Tag version → deploy to production
4. **Infrastructure**: Changes to main → update staging, tags → update production

## Testing Strategy
- **Framework**: Jest for backend and frontend testing (planned)
- **Approach**: Write code first, add tests after (no TDD initially)
- **Priority**: API tests, unit tests for critical paths
- **Coverage**: Focus on core business logic and integrations
- **Learning**: Gradual adoption of testing practices

## Development Environments
- **Development**: Local (backend: ts-node, frontend: Vite dev server)
- **Staging**: AWS EC2 with staging.cvhere.net (restricted access)
- **Production**: AWS EC2 with cvhere.net (public access)

## Documentation Strategy
- **Technical decisions**: Document immediately in DECISIONS.md and DISCUSSIONS.md
- **Merge docs to develop**: After decisions (excluding feature implementation)
- **Feature code**: Keep in feature branch until complete
- **Separate concerns**: Architecture decisions vs feature implementation
- **Main branch**: Gets docs through develop → main merges