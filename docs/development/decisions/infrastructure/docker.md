# Docker Deployment Decision

## 2025-09-04 - Docker-Based Deployment Strategy

**Context**: Need reliable, consistent deployment replacing manual file copying and service management
**Problem**: Current deployment has manual steps, dependency issues, file path confusion, service management problems

**Options Considered**:
1. **Continue manual deployment** - File copying + manual service management
2. **Docker containers** - Containerized backend/frontend with docker-compose
3. **Serverless** - Lambda functions (too complex for MVP)

**Decision**: Docker-based deployment with single server
**Rationale**: 
- **Eliminates manual steps** - No more dependency installation, service management
- **Consistent environments** - Same containers dev/staging/production
- **Easy rollbacks** - Container versioning and switching
- **Cost effective** - Single server with multiple containers
- **Scalable foundation** - Can move to orchestration later

**Implementation**:
- **Backend**: Node.js container with Fastify
- **Frontend**: Nginx container serving React build
- **Database**: PostgreSQL container (future)
- **Orchestration**: docker-compose for service management
- **Networking**: Docker network for inter-container communication

**Deployment Architecture**:
```
Single EC2 Instance:
├── cvhere-backend container (port 3001)
├── cvhere-frontend container (port 3000)
└── Docker network for communication
```

**Benefits**:
- **No manual dependency installation** - Everything in container images
- **Consistent file structure** - No more path confusion
- **Automatic service management** - Docker handles process lifecycle
- **Environment parity** - Same containers everywhere
- **Easy blue-green deployment** - Container swapping strategy

**Future Migration Path**:
1. **Phase 1**: Single server Docker (current)
2. **Phase 2**: Add blue-green deployment with container swapping
3. **Phase 3**: Multiple servers with load balancer
4. **Phase 4**: Container orchestration (ECS/EKS)

**Infrastructure Requirements**:
- **Docker installed** on EC2 instances
- **Docker Compose** for service orchestration
- **Container registry** for image storage (future)
- **Proper resource naming** - cvhere prefix, no AWS prefixes
