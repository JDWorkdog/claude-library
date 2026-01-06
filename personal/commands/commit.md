---
name: commit
description: Generate conventional commits from staged changes
---

# /commit Command

Generate well-structured conventional commits from staged changes.

## Usage

```
/commit              # Analyze staged changes and generate commit
/commit --dry-run    # Preview commit message without committing
/commit --amend      # Amend the previous commit (use carefully)
/commit -m "hint"    # Include hint about the change intent
```

## Process

1. **Check staged changes**
   ```bash
   git status
   git diff --cached
   ```

2. **Analyze the changes**
   - Files modified/added/deleted
   - Nature of changes (feature, fix, refactor, etc.)
   - Scope (which module/area)

3. **Check recent commits** for style consistency
   ```bash
   git log --oneline -10
   ```

4. **Generate commit message** following conventional commits

5. **Create the commit** (unless --dry-run)

## Conventional Commit Format

```
<type>(<scope>): <description>

[optional body]

[optional footer]
```

### Types

| Type | Description | Example |
|------|-------------|---------|
| `feat` | New feature | `feat(auth): add Google OAuth provider` |
| `fix` | Bug fix | `fix(api): handle null user in session` |
| `docs` | Documentation | `docs(readme): add deployment section` |
| `style` | Formatting (no logic change) | `style(ui): fix button alignment` |
| `refactor` | Code restructuring | `refactor(db): extract query helpers` |
| `perf` | Performance improvement | `perf(api): add query caching` |
| `test` | Adding/updating tests | `test(auth): add login flow tests` |
| `chore` | Maintenance tasks | `chore(deps): update dependencies` |

### Scopes (Examples)

| Scope | Area |
|-------|------|
| `api` | API procedures, routes |
| `db` | Database schema, migrations |
| `ui` | React components, styling |
| `auth` | Authentication |
| `config` | Configuration, environment |
| `test` | Test infrastructure |
| `ci` | CI/CD workflows |

## Commit Message Guidelines

### Subject Line
- **50 characters max** (hard limit: 72)
- **Imperative mood**: "add feature" not "added feature"
- **Lowercase** (except proper nouns)
- **No period** at the end

### Body (Optional)
- Wrap at 72 characters
- Explain **what** and **why**, not how
- Separate from subject with blank line

### Footer (Optional)
- Reference issues: `Fixes #123` or `Closes #456`
- Breaking changes: `BREAKING CHANGE: description`

## Output Format

```markdown
## Generated Commit

### Message
```
feat(scope): description

Optional body explaining the change in more detail.

Fixes #123
```

### Changes Summary
- `src/file1.ts` - Added new function
- `src/file2.ts` - Fixed bug in handler

### Ready to Commit?
[Y/n]
```

## Examples

### Feature Commit
```
feat(api): add user preferences endpoint

Adds new tRPC procedure for managing user preferences
including theme, notifications, and language settings.

Closes #42
```

### Bug Fix Commit
```
fix(auth): prevent session expiry during active use

Sessions were expiring even when users were actively
using the application. Now refreshes token on API calls.

Fixes #78
```

### Refactor Commit
```
refactor(db): consolidate user queries into repository

Moves scattered Prisma queries into a centralized
UserRepository class for better testability and reuse.
```

## Safety Rules

1. **Never commit secrets** - Check for .env values, API keys
2. **Review staged files** - Ensure nothing unexpected is staged
3. **Don't include generated files** - .next/, node_modules/, etc.
4. **Atomic commits** - One logical change per commit
5. **No --amend after push** - Only amend unpushed commits

## Integration

After committing, you may want to:
- `/review` - Review the committed changes
- `/test` - Run tests to verify
- Create a PR when ready
