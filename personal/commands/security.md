# Security Command

Perform a security audit of the codebase.

## Usage
```
/security              # Full security scan
/security --deps       # Dependency audit only
/security --quick      # Quick scan of critical areas
/security <file>       # Scan specific file
```

## Instructions

1. **Dependency Audit**: Run `npm audit` to check for vulnerable packages
2. **Code Scan**: Search for common vulnerability patterns
3. **Config Review**: Check security-related configuration
4. **Report Findings**: Categorize by severity with remediation steps

## Scan Areas

### Dependencies
```bash
npm audit
npm audit --audit-level=moderate
```

### Secret Detection
- Hardcoded passwords or API keys
- Secrets in client-side code
- Improper environment variable usage

### Authentication
- Unprotected routes that should require auth
- Session configuration issues
- Token handling problems

### Input Validation
- Missing Zod schemas on tRPC inputs
- SQL injection risks (raw queries)
- XSS vulnerabilities

### Configuration
- Security headers in Next.js config
- CORS settings
- Environment variable exposure

## Key Files to Check

- `src/env.js` - Environment validation
- `src/server/auth/` - Auth configuration
- `src/server/api/routers/` - API procedures
- `next.config.js` - Next.js security settings
- `.env.example` - Secret patterns

## Output Format

```
## Security Audit Report

**Scan Date**: YYYY-MM-DD
**Scope**: Full / Dependencies / Quick

### Critical Issues
- **[CRITICAL]** Category: Finding
  - Location: file:line
  - Risk: What could be exploited
  - Fix: Remediation steps

### High Severity
- **[HIGH]** ...

### Medium Severity
- **[MEDIUM]** ...

### Dependency Summary
| Severity | Count |
|----------|-------|
| Critical | X     |
| High     | X     |
| Moderate | X     |
| Low      | X     |

### Recommendations
1. Priority actions to take

### Overall Status
SECURE / NEEDS ATTENTION / CRITICAL ISSUES
```

## Do NOT

- Read actual `.env` files (only `.env.example`)
- Execute commands that could expose secrets
- Modify security-sensitive files without approval
