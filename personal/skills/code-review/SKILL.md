---
name: code-review
description: Perform comprehensive code reviews checking style, complexity, security, and performance. Use when reviewing PRs, analyzing code quality, checking for bugs, or when the user mentions review, code quality, best practices, or linting.
allowed-tools: Read, Grep, Glob
---

# Code Review Skill

Review code for quality, patterns, security, and best practices in TypeScript/React applications.

## Review Dimensions

### 1. Type Safety
- No `any` types without justification
- Proper Zod schemas for tRPC inputs
- Correct generic usage
- Null/undefined handling

### 2. tRPC Patterns
- `publicProcedure` vs `protectedProcedure` correctly used
- Input validation on all procedures
- Proper error handling with TRPCError
- Query vs mutation appropriate

### 3. Prisma Patterns
- Transactions for multi-operation mutations
- Avoid N+1 queries (use `include`/`select`)
- Index awareness for queries
- No raw SQL without parameterization

### 4. React/Next.js
- Server vs Client component boundaries
- Correct `'use client'` usage
- Proper data fetching patterns
- No unnecessary re-renders

### 5. Security
- Input validation
- Auth checks on protected routes
- No secrets in code
- XSS prevention

## Severity Levels

- **BLOCKER**: Bugs, security issues, data loss risk. Must fix.
- **MAJOR**: Significant quality issues. Should fix.
- **MINOR**: Style, minor improvements. Nice to fix.
- **SUGGESTION**: Optional enhancements.

## Output Format

```markdown
## Code Review

### Critical Issues
- **[BLOCKER]** file:line - Description
  - Fix: Recommendation

### Major Issues
- **[MAJOR]** file:line - Description
  - Fix: Recommendation

### Minor Issues
- **[MINOR]** file:line - Description

### Suggestions
- **[SUGGESTION]** file:line - Optional improvement

### Good Patterns
- Positive observations to continue
```

## Key Files to Reference

- `src/server/api/trpc.ts` - Procedure definitions
- `prisma/schema.prisma` - Data model
- `CLAUDE.md` - Project standards
