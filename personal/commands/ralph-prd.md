# Ralph PRD Command

Create a Product Requirements Document (PRD) optimized for autonomous execution via Ralph Loop.

## Usage
```
/ralph-prd                      # Start Ralph PRD creation process
/ralph-prd <feature name>       # Create Ralph PRD for specific feature
```

## What Makes This Different

A Ralph PRD differs from a standard PRD by including:
- **Automated verification steps** (tests, builds, linters)
- **Clear completion criteria** that Claude can verify programmatically
- **Phased implementation** with checkpoints
- **Explicit completion signal** for loop termination

## Process

1. **Analyze the initial request** to understand the feature/product context
2. **Ask 3-5 strategic clarifying questions** focusing on verification and completion criteria
3. **Generate Ralph-optimized PRD** using the structure below
4. **Save as** `ralph-prd-[feature-name].md`
5. **DO NOT implement** - confirm PRD is ready for Ralph Loop
6. **Offer to start Ralph Loop** with the generated PRD

## Clarifying Questions Strategy

**Focus on what enables autonomous execution.** Ask about:
- **Verification Method**: How will Claude know each requirement is met?
- **Test Coverage**: What tests already exist? What's the coverage target?
- **Build/Lint Requirements**: What commands must pass?
- **Completion Definition**: What specific state indicates "done"?
- **Scope Boundaries**: What should explicitly NOT be attempted?

### Question Format

**CRITICAL: Follow this exact formatting structure for questions:**

```
1. What verification commands should pass when complete?
   A. npm test && npm run build
   B. npm test && npm run typecheck && npm run build
   C. npm test && npm run lint && npm run typecheck && npm run build
   D. Custom (please specify)

2. What test coverage target should be met?
   A. Any passing tests
   B. 70% coverage on new code
   C. 80% coverage on new code
   D. 90%+ coverage on new code

3. What should be explicitly out of scope?
   A. UI changes (backend only)
   B. Database migrations
   C. External API integrations
   D. Multiple exclusions (please specify)

4. Are there existing patterns to follow?
   A. Yes, follow existing code conventions
   B. Yes, specific files to reference (please specify)
   C. No, greenfield implementation
   D. Unsure, Claude should discover patterns
```

This format allows rapid responses like: "1C, 2B, 3A, 4A"

## Ralph PRD Structure

Generate a PRD with these sections optimized for Ralph Loop:

### 1. Overview
Brief description of the feature. State the primary goal in one sentence.

### 2. Context
- What exists in the codebase that this builds on
- Key files/patterns to reference
- Technology stack constraints

### 3. Requirements (Numbered)
Specific, numbered requirements. Each requirement should be independently verifiable.

Format:
```
1. [Requirement description]
   - Verification: [How to verify this is complete]
```

### 4. Non-Goals (Critical for Ralph)
Explicitly state what Claude should NOT attempt. This prevents scope creep during iteration.

### 5. Implementation Phases
Break work into phases, each with its own verification:

```markdown
## Phase 1: [Name]
- Task 1
- Task 2
- **Verification**: [Command or check that proves phase complete]

## Phase 2: [Name]
- Task 1
- Task 2
- **Verification**: [Command or check that proves phase complete]
```

### 6. Verification Commands
List all commands that must pass for completion:
```bash
npm run typecheck    # Must pass with no errors
npm test             # All tests must pass
npm run build        # Must complete successfully
npm run lint         # No lint errors (if applicable)
```

### 7. Completion Criteria
Explicit checklist that Claude will verify:
```markdown
- [ ] All requirements implemented
- [ ] All verification commands pass
- [ ] No TypeScript errors
- [ ] Test coverage meets target
- [ ] No new lint warnings
```

### 8. Completion Signal
The exact phrase Claude should output when done:
```
Output <promise>COMPLETE</promise> when all completion criteria are verified.
```

## Target Audience

Write for **Claude Code executing autonomously**:
- Be explicit and unambiguous
- Every requirement must have a verification method
- Include exact commands to run
- Specify file patterns and naming conventions
- State what NOT to do as clearly as what TO do

## Output Specifications

- **Format**: Markdown (`.md`)
- **Filename**: `ralph-prd-[feature-name].md` (use kebab-case)

## After Generation

1. **DO NOT start implementing** the feature
2. **Review with user** - especially verification commands and completion criteria
3. **Confirm PRD is Ralph-ready** before proceeding
4. **Offer to start Ralph Loop**:
   ```
   Ready to start? Run:
   @ralph-loop "$(cat ralph-prd-[feature-name].md)"
   ```

## Example Output

```markdown
# Ralph PRD: User Authentication

## Overview
Implement JWT-based user authentication with login, register, and protected routes.

## Context
- Express.js application with TypeScript
- Prisma ORM with PostgreSQL
- Existing User model in prisma/schema.prisma
- Tests use Vitest

## Requirements

1. **User Registration Endpoint**
   - POST /auth/register accepts email and password
   - Passwords hashed with bcrypt (min 10 rounds)
   - Returns JWT token on success
   - Verification: `npm test -- --grep "register"` passes

2. **User Login Endpoint**
   - POST /auth/login accepts email and password
   - Validates credentials against database
   - Returns JWT token on success
   - Verification: `npm test -- --grep "login"` passes

3. **Protected Route Middleware**
   - Validates JWT from Authorization header
   - Attaches user to request object
   - Returns 401 for invalid/missing tokens
   - Verification: `npm test -- --grep "middleware"` passes

4. **Current User Endpoint**
   - GET /auth/me returns current user (protected)
   - Verification: `npm test -- --grep "current user"` passes

## Non-Goals
- Password reset functionality
- OAuth/social login
- Email verification
- Rate limiting
- Session management (JWT only)

## Implementation Phases

### Phase 1: Database & Utils
- Add passwordHash field to User model if missing
- Create auth utility functions (hash, verify, generateToken)
- **Verification**: `npx prisma db push` succeeds, unit tests pass

### Phase 2: Endpoints
- Implement /auth/register
- Implement /auth/login
- Implement /auth/me
- **Verification**: `npm test -- --grep "auth"` passes

### Phase 3: Middleware & Integration
- Create auth middleware
- Apply to protected routes
- Integration tests
- **Verification**: Full test suite passes

## Verification Commands
```bash
npm run typecheck    # Must pass with no errors
npm test             # All tests must pass
npm run build        # Must complete successfully
```

## Completion Criteria
- [ ] All 4 requirements implemented
- [ ] All verification commands pass
- [ ] Test coverage > 80% on new code
- [ ] No TypeScript errors

## Completion Signal
Output <promise>COMPLETE</promise> when all completion criteria are verified.
```
