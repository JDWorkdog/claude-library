---
name: pr-creation
description: Create well-structured pull requests with conventional commits and comprehensive descriptions. Use when creating PRs, writing commit messages, or preparing code for review.
allowed-tools: Read, Grep, Glob, Bash
---

# PR Creation Skill

Create professional pull requests with conventional commits and clear descriptions.

## Conventional Commit Format

```
<type>(<scope>): <description>

[optional body]

[optional footer]
```

### Types
| Type | Description |
|------|-------------|
| `feat` | New feature |
| `fix` | Bug fix |
| `docs` | Documentation only |
| `style` | Formatting, no code change |
| `refactor` | Code change, no new feature or fix |
| `perf` | Performance improvement |
| `test` | Adding/updating tests |
| `chore` | Maintenance tasks |

### Scopes (Project-Specific)
- `api` - tRPC routers and procedures
- `db` - Prisma schema and migrations
- `ui` - React components and pages
- `auth` - Authentication/NextAuth
- `config` - Configuration files

### Examples
```
feat(api): add user profile update endpoint
fix(auth): resolve session expiration handling
docs(readme): update deployment instructions
refactor(db): normalize user preferences table
```

## PR Description Template

```markdown
## Summary
Brief description of changes (1-3 sentences)

## Changes
- Change 1
- Change 2
- Change 3

## Type
- [ ] Feature
- [ ] Bug fix
- [ ] Refactor
- [ ] Documentation

## Testing
- [ ] Unit tests added/updated
- [ ] Manual testing completed
- [ ] All tests passing

## Screenshots (if UI changes)
[Add screenshots here]

## Notes for Reviewers
Any context reviewers should know
```

## Commit Message Best Practices

1. **Subject line**: 50 chars max, imperative mood ("Add" not "Added")
2. **Body**: Wrap at 72 chars, explain what and why
3. **Footer**: Reference issues ("Fixes #123")

## PR Checklist

Before creating PR:
- [ ] Code follows project patterns
- [ ] Tests added for new functionality
- [ ] Documentation updated if needed
- [ ] No console.log or debug statements
- [ ] Commits are clean and logical
