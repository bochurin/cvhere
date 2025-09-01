# Documentation Strategy Decision

## 2024-12-19 - Selective Merging Strategy

**Context**: How to manage documentation commits and merging across branches
**Problem**: Need architectural decisions available to all developers while keeping feature implementation details with feature code

**Options Considered**:
1. **All docs together** - Everything committed and merged together
2. **Branch-based separation** - Common docs to main, feature docs stay in branches
3. **Selective merging** - Strategic/architectural docs to main, implementation tracking in branches

**Decision**: Selective Merging Strategy
**Rationale**: 
- **Architectural decisions** need to be available immediately to all developers
- **Project status** should be visible across all branches
- **Feature implementation details** should stay with feature code until complete
- **Reference materials** support all development work

**Implementation**:

### Merge to Develop
- **Project docs** (strategic): CONCEPT.md, ARCHITECTURE.md, MVP-SCOPE.md, SECURITY.md, WORKFLOW.md
- **Decisions** (architectural): All technical decisions and discussions
- **Progress log** (common status): Overall development phases and current status
- **Reference materials** (supporting): Tools, knowledge base, chat backup
- **Documentation structure**: README files and navigation

### Stay in Feature Branches
- **Feature logs** (implementation tracking): Specific feature development details and progress
- **Feature-specific code**: Implementation until feature complete

### Team Workflow
- **Documentation flow**: feature → develop → main
- **Integration testing**: Documentation tested in develop before main
- **Consistency**: Same workflow for code and documentation

**Benefits**:
- **Immediate availability** of architectural decisions to all developers
- **Project visibility** - everyone sees current development status
- **Feature isolation** - implementation details don't clutter main branch
- **Clean separation** between strategy and implementation

**Workflow**:
1. **Make architectural decisions** - Document in decisions/
2. **Update project status** - Update PROGRESS-LOG.md
3. **Commit common docs** - Project, decisions, progress, reference
4. **Merge to develop** - Integration testing and team coordination
5. **Merge develop to main** - Final documentation deployment
6. **Feature work continues** - Feature logs stay in feature branch until complete