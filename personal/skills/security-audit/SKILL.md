---
name: security-audit
description: Perform comprehensive security audits following OWASP guidelines. Use when checking for vulnerabilities, auditing authentication, reviewing API security, or before deployment.
allowed-tools: Read, Grep, Glob, Bash
---

# Security Audit Skill

Audit applications for security vulnerabilities following OWASP Top 10 guidelines.

## OWASP Top 10 (2021) Quick Reference

| ID | Category | Check |
|----|----------|-------|
| A01 | Broken Access Control | Auth on all protected routes |
| A02 | Cryptographic Failures | No secrets in code, proper hashing |
| A03 | Injection | Parameterized queries, input validation |
| A05 | Security Misconfiguration | Secure headers, no debug in prod |
| A06 | Vulnerable Components | `npm audit`, update deps |
| A07 | Auth Failures | Session management, password policy |

## Quick Checks

### Dependency Vulnerabilities
```bash
npm audit
npm audit --audit-level=moderate
```

### Secret Detection
```bash
# Check for potential secrets
grep -r "password\s*=" --include="*.ts" src/
grep -r "api[_-]?key" --include="*.ts" src/
grep -r "secret" --include="*.ts" src/
```

### Auth Verification
```bash
# Find public procedures that should be protected
grep -r "publicProcedure" src/server/api/routers/
```

## Stack-Specific Checks

### tRPC
- All mutations use `protectedProcedure` unless explicitly public
- Zod validation on all inputs
- No sensitive data in error messages

### Prisma
- No raw SQL (`$queryRaw`, `$executeRaw`)
- Parameterized queries only
- createdById checks for user-owned resources

### NextAuth
- Secure session configuration
- Callback validation
- Token expiration set

### Environment
- Secrets in `env.js` schema
- No secrets in client-side code
- `.env` in `.gitignore`

## Severity Levels

- **CRITICAL**: Immediate exploitation risk
- **HIGH**: Significant vulnerability
- **MEDIUM**: Moderate risk
- **LOW**: Minor issue
- **INFO**: Best practice recommendation

## Output Format

```markdown
## Security Audit Report

### Critical
- **[CRITICAL]** Finding - Location - Remediation

### High
- **[HIGH]** Finding - Location - Remediation

### Dependency Summary
- Total: X vulnerabilities
- Critical: X, High: X, Medium: X, Low: X

### Recommendations
1. Prioritized actions
```

## Key Files to Audit

- `src/env.js` - Environment validation
- `src/server/auth/` - Auth configuration
- `src/server/api/routers/` - API procedures
- `.env.example` - Secret patterns
