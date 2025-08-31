# CVHere

CV building and searching application

## Documentation

Project documentation is organized in the `docs/` folder:

- **[CONCEPT.md](docs/CONCEPT.md)** - Platform vision, features, and core concepts
- **[ARCHITECTURE.md](docs/ARCHITECTURE.md)** - Current tech stack and infrastructure overview
- **[DECISIONS.md](docs/DECISIONS.md)** - Technical decisions log with rationale and history
- **[DISCUSSIONS.md](docs/DISCUSSIONS.md)** - Discussion log for ideas and questions during development
- **[DEVELOPMENT.md](docs/DEVELOPMENT.md)** - Development workflow, CI/CD, and testing strategy
- **[SECURITY.md](docs/SECURITY.md)** - Security measures, privacy, and compliance
- **[MVP-SCOPE.md](docs/MVP-SCOPE.md)** - MVP features, limitations, and success metrics
- **[code/](docs/code/)** - Implementation decisions organized by feature branches

## Development Workflow

### Discussing New Ideas

To discuss new ideas or changes during development, use:

**"Discuss: [your idea/question]"**

**Examples:**
- "Discuss: should we use Redis for caching?"
- "Discuss: do we need a separate microservice for authentication?"
- "Discuss: should we change the database structure?"

**Process:**
1. **Clarification** - Questions to understand the context
2. **Discussion** - Consider alternatives and implications
3. **Decision** - Update all relevant documentation if decision is made
4. **Log** - Record discussion in [DISCUSSIONS.md](docs/DISCUSSIONS.md)

### Feature Development

To start implementing a new feature, use:

**"Feature: [feature name] - [brief description]"**

**Examples:**
- "Feature: Basic Auth - JWT authentication system"
- "Feature: Profile Builder - Atomic data model for user profiles"
- "Feature: PDF Export - Generate CVs from profile data"

**Process:**
1. **Plan Creation** - Build detailed step-by-step plan
2. **Plan Confirmation** - Review and adjust before starting
3. **Step-by-step Execution** - Implement one step at a time
4. **Plan Updates** - If plan changes, update feature log immediately
5. **Commit After Steps** - Clean commits with meaningful messages
6. **Progress Updates** - Mark completed steps in feature logs

**Benefits:** Clear scope, documented plan evolution, clean git history, progress tracking