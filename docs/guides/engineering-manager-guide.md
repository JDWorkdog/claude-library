# Engineering Manager Agent Guide

The Engineering Manager is an **orchestrator agent** that coordinates development tasks by delegating to specialist agents. Unlike Ralph Wiggum's autonomous loops, the Engineering Manager works within a single session, providing human-visible progress and the ability to intervene.

## When to Use Engineering Manager vs Ralph Wiggum

| Scenario | Engineering Manager | Ralph Wiggum |
|----------|---------------------|--------------|
| **Task duration** | Minutes to hours | Hours to days |
| **Human involvement** | Can intervene anytime | Set and forget |
| **Verification** | Human can review | Must be automated |
| **Design decisions** | Can ask for input | Must be predetermined |
| **Scope** | Bounded, clear | Can be open-ended |
| **Visibility** | See all work happening | See iterations in terminal |
| **Parallel work** | Coordinates specialists | Single focused loop |

### Use Engineering Manager When:

- ✅ Task is complex but bounded (fix a bug, add a feature)
- ✅ You want to review work before it's committed
- ✅ Multiple specialists are needed (review + tests + security)
- ✅ Design decisions may be needed mid-task
- ✅ Task requires coordination, not iteration

### Use Ralph Wiggum When:

- ✅ Task is well-defined with automated verification
- ✅ You can walk away and check back later
- ✅ Iteration is expected (TDD, getting tests to pass)
- ✅ Task is greenfield with clear completion criteria
- ✅ No human judgment needed during execution

## How the Engineering Manager Works

```
┌─────────────────────────────────────────────────────────────┐
│                   Engineering Manager                        │
│                                                              │
│  ┌──────────────┐                                           │
│  │ Analyze Task │                                           │
│  └──────┬───────┘                                           │
│         │                                                    │
│         ▼                                                    │
│  ┌──────────────────────────────────────────────────────┐   │
│  │              Select Specialists                        │   │
│  │  ┌────────────┐ ┌────────────┐ ┌────────────┐        │   │
│  │  │   Code     │ │   Test     │ │  Security  │  ...   │   │
│  │  │  Reviewer  │ │  Engineer  │ │  Scanner   │        │   │
│  │  └────────────┘ └────────────┘ └────────────┘        │   │
│  └──────────────────────────────────────────────────────┘   │
│         │                                                    │
│         ▼                                                    │
│  ┌──────────────┐                                           │
│  │  Aggregate   │                                           │
│  │   Results    │                                           │
│  └──────┬───────┘                                           │
│         │                                                    │
│         ▼                                                    │
│  ┌──────────────┐                                           │
│  │   Report &   │                                           │
│  │ Await Approval│                                          │
│  └──────────────┘                                           │
└─────────────────────────────────────────────────────────────┘
```

The Engineering Manager:
1. **Analyzes** the incoming request
2. **Selects** appropriate specialist agents based on task type
3. **Delegates** work to those specialists
4. **Aggregates** their outputs
5. **Reports** status and awaits human approval for actions like `git push`

## Triggering the Engineering Manager

### Method 1: Explicit Request

Ask Claude to use the engineering manager:

```
Use the engineering-manager agent to implement user authentication with JWT tokens.
```

### Method 2: Complex Task Recognition

Claude will often invoke it automatically for multi-step tasks:

```
Implement a new API endpoint for user preferences with tests and documentation.
```

### Method 3: Via Task Tool (Programmatic)

If building automation:

```javascript
Task({
  subagent_type: "engineering-manager",
  prompt: "Implement feature X with full quality checks"
})
```

## What to Provide as Input

### Minimum Input

A clear description of what you want:

```
Add a password reset feature to the authentication system.
```

### Better Input

Context + requirements:

```
Add a password reset feature to the authentication system.

Context:
- We use JWT tokens stored in httpOnly cookies
- Email service is already configured (src/lib/email.ts)
- User model is in prisma/schema.prisma

Requirements:
- POST /auth/forgot-password - sends reset email
- POST /auth/reset-password - accepts token and new password
- Reset tokens expire after 1 hour
- Rate limit: 3 requests per hour per email
```

### Best Input

Context + requirements + constraints:

```
Add a password reset feature to the authentication system.

Context:
- We use JWT tokens stored in httpOnly cookies
- Email service is already configured (src/lib/email.ts)
- User model is in prisma/schema.prisma

Requirements:
- POST /auth/forgot-password - sends reset email
- POST /auth/reset-password - accepts token and new password
- Reset tokens expire after 1 hour
- Rate limit: 3 requests per hour per email

Constraints:
- Don't modify the existing login flow
- Use the existing email templates pattern
- Tests should use the existing test database setup

After Implementation:
- Run full test suite
- Review for security issues
- Update API documentation
```

### Using a PRD

For substantial features, reference a PRD:

```
Implement the feature described in prd-password-reset.md using the engineering-manager agent.
```

Or create one first:

```bash
/prd password-reset
# Answer the clarifying questions
# PRD is saved to prd-password-reset.md

# Then:
Use the engineering-manager to implement prd-password-reset.md
```

## Agent Delegation Matrix

The Engineering Manager automatically selects specialists based on task type:

| Task Type | Agents Involved |
|-----------|-----------------|
| New feature | Architecture Advisor → Implementation → Code Reviewer → Test Engineer → Documentation Writer |
| Bug fix | Code Reviewer → Implementation → Test Engineer |
| Refactoring | Architecture Advisor → Code Reviewer → Test Engineer |
| Security-related change | Security Scanner → Code Reviewer → Test Engineer |
| Database change | Database Specialist → Architecture Advisor → Code Reviewer → Test Engineer |
| UI component | Frontend UX Expert → Code Reviewer → Test Engineer |
| Production issue | Incident Responder → relevant specialists |

## Quality Gates

The Engineering Manager enforces these gates before completing:

1. **Code Review** - Automated review for patterns, bugs, style
2. **Tests** - All tests must pass
3. **Security Scan** - No new vulnerabilities introduced
4. **Build** - Production build must succeed
5. **Type Check** - TypeScript must pass (if applicable)

## Output Format

When the Engineering Manager completes, you'll receive:

```
## Summary
What was accomplished

## Changes Made
- src/routes/auth.ts - Added password reset endpoints
- src/lib/tokens.ts - Added reset token generation
- tests/auth.test.ts - Added reset flow tests

## Quality Status
- Code Review: ✅ Passed (minor suggestions noted)
- Tests: ✅ 47/47 passing
- Security: ✅ No issues found
- Build: ✅ Successful

## Next Steps
Ready for push approval. Review changes with `git diff` then approve push.
```

## Example Session

```
User: Add rate limiting to our API endpoints using the engineering-manager.

Engineering Manager:
├── Analyzing task...
├── Consulting Architecture Advisor for rate limiting patterns
│   └── Recommends: Token bucket with Redis backend
├── Implementing rate limiting middleware
├── Running parallel validation:
│   ├── Code Review: Checking implementation
│   ├── Test Engineer: Generating tests
│   └── Security Scanner: Checking for bypasses
├── Aggregating results...
└── Reporting status

## Summary
Implemented rate limiting middleware with Redis backend.

## Changes Made
- src/middleware/rateLimit.ts - New rate limiting middleware
- src/routes/api.ts - Applied middleware to routes
- tests/rateLimit.test.ts - Unit and integration tests

## Quality Status
- Code Review: ✅ Passed
- Tests: ✅ 12/12 passing
- Security: ✅ No bypass vulnerabilities found
- Build: ✅ Successful

## Next Steps
Ready for push approval.
```

## Comparison Summary

| Aspect | Engineering Manager | Ralph Wiggum |
|--------|---------------------|--------------|
| **Mechanism** | Delegation to specialists | Iterative loop with same prompt |
| **Loop location** | None (single pass) | Session-level via hooks |
| **Iteration** | Specialists may iterate internally | Explicit iteration until completion |
| **Completion** | After quality gates pass | After completion promise detected |
| **Human involvement** | Can review and approve | Minimal until completion |
| **Best for** | Coordinated, bounded tasks | Autonomous, iterative tasks |

## Further Reading

- [Engineering Manager Agent Definition](../../personal/agents/engineering-manager.md)
- [Ralph Wiggum Overview](ralph-wiggum-overview.md)
- [Ralph Wiggum Usage](ralph-wiggum-usage.md)
- [Creating PRDs](/prd command)
