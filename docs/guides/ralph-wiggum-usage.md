# Preparing and Running Ralph Wiggum Loops

This guide covers how to prepare your task, write effective prompts, and run Ralph Wiggum loops successfully.

## Before You Start: Preparation

Ralph Wiggum works best with well-defined tasks. Preparation is key.

### Step 1: Create a Ralph PRD (Recommended)

For substantial features, use the Ralph-optimized PRD command:

```bash
/ralph-prd user-authentication
```

The `/ralph-prd` command will:
1. Ask clarifying questions focused on verification and completion
2. Generate a PRD with automated verification steps
3. Include phased implementation with checkpoints
4. Add explicit non-goals to prevent scope creep
5. Save it as `ralph-prd-user-authentication.md`

Then run with:
```bash
@ralph-loop "$(cat ralph-prd-user-authentication.md)"
```

A Ralph PRD differs from a standard `/prd` by including machine-verifiable completion criteria.

### Step 2: Define Clear Completion Criteria

Ralph needs to know when it's done. Transform vague goals into specific, verifiable criteria:

```
❌ Vague: "Build a good API"

✅ Specific:
- All CRUD endpoints implemented
- Input validation on all endpoints
- Tests passing with >80% coverage
- OpenAPI documentation generated
- No TypeScript errors
```

### Step 3: Ensure Automatic Verification

Ralph works best when it can verify its own progress:

| Verification Method | Example |
|---------------------|---------|
| Test suite | `npm test` returns exit code 0 |
| Type checker | `npm run typecheck` passes |
| Linter | `npm run lint` shows no errors |
| Build | `npm run build` succeeds |
| Coverage | Coverage report shows >80% |

If verification requires human judgment, Ralph isn't the right tool.

## Writing Effective Prompts

### The Prompt Structure

A Ralph-optimized prompt has four parts:

```markdown
## Context
[What exists, what you're building on]

## Requirements
[Specific, numbered requirements]

## Verification
[How to check if requirements are met]

## Completion Signal
Output <promise>COMPLETE</promise> when all requirements are verified.
```

### Example: Full Feature Prompt

```markdown
Build a REST API for todo management.

## Context
- This is a new Express.js application
- Use TypeScript strict mode
- Tests use Vitest

## Requirements
1. CRUD endpoints: GET /todos, GET /todos/:id, POST /todos, PUT /todos/:id, DELETE /todos/:id
2. Input validation using Zod schemas
3. Error handling middleware with proper HTTP status codes
4. Request logging middleware
5. Unit tests for all endpoints
6. Integration tests for the full API flow

## Verification Steps
After implementation, run these checks:
1. `npm run typecheck` - must pass with no errors
2. `npm test` - all tests must pass
3. `npm run build` - must complete successfully

## Completion
When ALL verification steps pass, output: <promise>COMPLETE</promise>
```

### Example: Incremental/Phased Prompt

For larger tasks, define phases:

```markdown
Implement user authentication system in phases.

## Phase 1: Database Schema
- User model with email, passwordHash, createdAt
- Prisma migration created and applied
- Verification: `npx prisma db push` succeeds

## Phase 2: Authentication Logic
- Password hashing with bcrypt
- JWT token generation and verification
- Verification: Unit tests pass for auth utilities

## Phase 3: API Endpoints
- POST /auth/register - create new user
- POST /auth/login - return JWT token
- GET /auth/me - return current user (protected)
- Verification: Integration tests pass

## Phase 4: Middleware
- Authentication middleware for protected routes
- Verification: Protected routes reject invalid tokens

## Completion
When all phases complete and `npm test` passes: <promise>COMPLETE</promise>
```

### Example: Self-Correction Pattern

For TDD workflows:

```markdown
Implement feature X using test-driven development.

## Process
1. Write failing tests first
2. Implement minimum code to pass tests
3. Run `npm test`
4. If tests fail, analyze output and fix
5. Refactor if needed while keeping tests green
6. Repeat until all requirements covered

## Requirements
[Your specific requirements here]

## Completion
When `npm test` passes with all requirements covered: <promise>COMPLETE</promise>
```

## Running Ralph Loop

### Basic Usage

```bash
@ralph-loop "<your prompt>"
```

> **Note:** Use `@ralph-loop` (the `@` prefix) when invoking MCP tools from terminal. The `/` prefix is for built-in slash commands only.

### Full Example

```bash
@ralph-loop "Build a REST API for todos.

## Requirements
1. CRUD endpoints for todos
2. Input validation with Zod
3. Tests with >80% coverage
4. TypeScript strict mode

## Verification
- npm run typecheck passes
- npm test passes
- npm run build succeeds

Output COMPLETE when all verification passes."
```

### Monitoring Progress

While Ralph runs, you'll see:
- Each iteration's work in your terminal
- Files being created/modified
- Test runs and their output
- Build attempts

### Canceling a Loop

If you need to stop:

```bash
@cancel-ralph
```

This gracefully stops the loop after the current iteration.

## Troubleshooting

### Loop Never Completes

**Symptoms**: Hits max iterations without outputting completion promise

**Causes & Fixes**:
1. **Completion criteria too strict**: Relax requirements or break into phases
2. **Verification always fails**: Check if your test/build commands work manually
3. **Prompt ambiguous**: Add more specific requirements
4. **Task too large**: Break into smaller Ralph loops

### Loop Completes Too Early

**Symptoms**: Outputs completion promise before task is actually done

**Causes & Fixes**:
1. **Verification too lenient**: Add more specific checks
2. **Requirements unclear**: Be more explicit about what "done" means
3. **Missing verification step**: Ensure all requirements have corresponding verification

### Stuck in Repetitive Pattern

**Symptoms**: Same error/output repeating each iteration

**Causes & Fixes**:
1. **Deterministic failure**: The approach fundamentally doesn't work; revise prompt
2. **Missing context**: Add more background information to prompt
3. **External dependency**: Something outside the loop needs to change

## Best Practices

### Do

- ✅ Set iteration limits as a safety net
- ✅ Use automated verification (tests, builds, linters)
- ✅ Start with a PRD for complex features
- ✅ Break large tasks into phases
- ✅ Include specific, numbered requirements
- ✅ Test your verification commands manually first

### Don't

- ❌ Use vague completion criteria ("make it good")
- ❌ Rely on human judgment for verification
- ❌ Start without clear requirements
- ❌ Run without iteration limits on untested prompts
- ❌ Expect Ralph to make design decisions

## When to Use Engineering Manager Instead

Ralph Wiggum is for **autonomous iteration**. The Engineering Manager agent is better when you need:

- Human judgment during the process
- Coordination across multiple specialists
- Bounded tasks with clear scope
- Interactive refinement

See [Engineering Manager Guide](engineering-manager-guide.md) for comparison.

## Further Reading

- [Ralph Wiggum Overview](ralph-wiggum-overview.md)
- [Installing Ralph Wiggum](ralph-wiggum-installation.md)
- [Engineering Manager Guide](engineering-manager-guide.md)
