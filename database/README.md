# Database

PostgreSQL database setup and management for CVHere.

## Structure

- `migrations/` - Database schema changes
- `seeds/` - Initial data for development
- `scripts/` - Maintenance and backup scripts

## Setup

```bash
# Create database
createdb cvhere_development
createdb cvhere_test

# Run migrations
npm run migrate

# Seed development data
npm run seed
```

<!-- TODO: Create initial migration files -->
<!-- TODO: Set up database connection configuration -->
<!-- TODO: Create seed data for development -->