# Feature: Basic Authentication System

## Branch History
- **`feature/basic-auth`** (2024-12-19) - Cancelled due to complexity, started with email service and config
- **Future iteration** - Simplified approach after Phase 3 completion

## Next Iteration: 2024-12-19 - Simplified Auth After CI/CD

**Branch**: `feature/basic-auth` (ready to restart)
**Goal**: Implement minimal JWT-based authentication system
**Prerequisites**: CI/CD pipeline complete ✅
**Approach**: Start simple, add complexity incrementally

## Feature Plan

### ✅ Database Schema (Completed)
- ✅ Create Prisma schema with User model (id, email, password, createdAt)
- ✅ Generate Prisma client for type-safe database access
- ✅ Start PostgreSQL with Docker Compose
- ✅ Push schema to database (npm run db:push)
- ✅ Add email verification fields to User model (emailVerified, verificationToken)
- ✅ Add password reset fields to User model (resetToken, resetTokenExpiry)
- ✅ Update database schema (npm run db:push)

### ✅ Email Service Setup (Completed)
- ✅ Choose email service provider (AWS SES with replaceable architecture)
- ✅ Configure email templates for verification and password reset
- ✅ Set up email service module with TypeScript
- ✅ Implement runtime configuration system with file watching
- ✅ Add per-provider email limits and priority array

### 📋 Backend API - Core Auth (Cancelled)
- 📋 Set up Fastify server with TypeScript and middleware
- 📋 Implement user registration endpoint (POST /api/auth/register)
- 📋 Implement email verification endpoint (GET /api/auth/verify/:token)
- 📋 Implement user login endpoint (POST /api/auth/login)
- 📋 Add JWT token generation and validation middleware
- 📋 Create protected route example (GET /api/auth/profile)

### 🕰️ Phase 1: Minimal Auth (Next)
- 🕰️ JWT-only authentication (no email verification) // TODO: Install jsonwebtoken and bcrypt packages
- 🕰️ Basic user registration endpoint (POST /api/auth/register) // TODO: Add password validation and user creation
- 🕰️ Basic login endpoint (POST /api/auth/login) // TODO: Implement password verification and JWT generation
- 🕰️ Password hashing with bcrypt // TODO: Hash passwords before storing in database
- 🕰️ JWT middleware for protected routes // TODO: Create JWT verification middleware
- 🕰️ Simple frontend login/register forms // TODO: Build React forms with validation
- 🕰️ User profile endpoint (GET /api/auth/profile) // TODO: Return user data from JWT token

### 🕰️ Phase 2: Enhanced Auth (Later)
- 🕰️ Email verification system // TODO: Add email verification endpoints and templates
- 🕰️ Password reset functionality // TODO: Implement password reset with secure tokens
- 🕰️ Rate limiting and security headers // TODO: Add fastify-rate-limit and helmet plugins
- 🕰️ User session management // TODO: Add session storage and refresh tokens
- 🕰️ Remember me functionality // TODO: Implement persistent login with secure cookies

## Success Criteria

- ✅ User can register with email/password
- ✅ Email verification required before login
- ✅ User receives verification email with clickable link
- ✅ User can login only after email verification
- ✅ JWT token stored in localStorage
- ✅ Protected routes work correctly
- ✅ User can request password reset via email
- ✅ Password reset flow works securely with tokens
- ✅ Comprehensive error handling implemented
- ✅ Full authentication flow working end-to-end

## Technical Decisions

- **Backend Framework**: Fastify (TypeScript-first, performance)
- **Database**: Prisma ORM with PostgreSQL
- **Authentication**: JWT tokens with bcrypt password hashing
- **Email Service**: Nodemailer with Gmail/SendGrid for verification and recovery
- **Token Security**: Crypto-random tokens for email verification and password reset
- **Frontend State**: React Context + localStorage
- **Validation**: Fastify JSON schema validation + email format validation
- **Security**: Fastify plugins (helmet, cors, rate-limit) + token expiration
- **Configuration**: Runtime config file with file watching, per-provider email limits

## Current Status

**Status**: READY TO START - 2024-12-19
**Prerequisites**: CI/CD pipeline complete ✅
**Approach**: Minimal viable authentication first
**Previous Work**: Database schema and email service can be reused later

## Cross-Feature Dependencies

**Depends on**: ci-cd-pipeline (needs proper deployment for production auth) ✅
**Depends on**: basic-app (foundation with health checks and configuration) ✅
**Learning**: Complex features need solid infrastructure foundation first

## Implementation Plan

**Phase 1 - Minimal Auth (1-2 days)**:
1. **Database setup** - Reuse existing Prisma schema (User model) // TODO: Update User model for JWT-only auth
2. **Backend endpoints** - Register, login, profile (JWT-only) // TODO: Implement POST /api/auth/register endpoint
3. **Frontend forms** - Simple login/register UI // TODO: Create login/register React components
4. **Protected routes** - JWT middleware and React auth context // TODO: Add JWT middleware to backend
5. **Deploy and test** - Use new CI/CD pipeline // TODO: Test auth system with CI/CD deployment

**Phase 2 - Enhanced Auth (later)**:
1. **Email verification** - Reuse existing email service
2. **Password reset** - Token-based recovery
3. **Security enhancements** - Rate limiting, session management