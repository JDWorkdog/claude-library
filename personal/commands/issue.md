---
description: Create a GitHub issue to track bugs, enhancements, or tasks
argument-hint: [type] [title]
allowed-tools: Bash(git:*), Bash(gh:*)
---

# Create Issue Command

Creates a GitHub issue with rich context capture and auto-labels.

## Current Context
- Current branch: !`git branch --show-current`
- Git status: !`git status --short`
- Recent commits: !`git log --oneline -5`
- Uncommitted changes: !`git diff --stat 2>/dev/null | tail -5`

## Usage
`/issue [type] [title]`

### Issue Types & Labels
| Type | Label | Use for |
|------|-------|---------|
| `bug` | `bug` | Something isn't working |
| `enhancement` | `enhancement` | Improve existing feature |
| `feature` | `enhancement` | New capability |
| `docs` | `documentation` | Documentation improvement |
| `task` | `task` | General work item |
| `refactor` | `refactor` | Code cleanup/refactor |

## Examples
```bash
# Interactive mode (asks for details)
/issue

# Quick bug report
/issue bug Pipeline timeout on premium preset

# Enhancement suggestion
/issue enhancement Add retry logic to hypothesis harness

# Feature request
/issue feature Export analysis to Excel format

# Documentation fix
/issue docs Update README with new pipeline stages

# Task/todo item
/issue task Clean up old test fixtures
```

## Behavior

### 1. Parse Arguments
If arguments provided:
- First word: check if it's a known type (bug/enhancement/feature/docs/task/refactor)
- Remaining text: use as the issue title

If no arguments or no type specified:
- Ask user interactively for issue type
- Ask user for title if not provided

### 2. Gather Issue Details

**Always ask for:**
- Description: What is this issue about? (Can be brief)

**For bugs, also ask:**
- Steps to reproduce (if applicable)
- Expected vs actual behavior

**For features/enhancements, also ask:**
- Why is this needed? (motivation)
- Any specific requirements?

### 3. Auto-Capture Context

Include in issue body automatically:
- **Branch**: Current git branch
- **Recent commits**: Last 3-5 commits on this branch
- **Modified files**: If there are uncommitted changes, list them

### 4. Check Labels Exist

Before creating, verify the label exists:
```bash
gh label list --limit 100 | grep -i "<label>"
```

If label doesn't exist:
- Warn user: "Label '<label>' not found in repo. Creating issue without label."
- Continue without the label (don't fail)

### 5. Create the Issue

```bash
gh issue create \
  --title "<title>" \
  --body "$(cat <<'EOF'
## Description
<user description>

## Context
- **Branch**: `<branch>`
- **Recent commits**:
  - `<commit1>`
  - `<commit2>`
  - `<commit3>`
<if uncommitted changes>
- **Uncommitted changes**:
```
<diff stat>
```
</if>

<if bug>
## Reproduction
<user-provided steps or "N/A">

## Expected vs Actual
- **Expected**: <expected>
- **Actual**: <actual>
</if>

<if feature/enhancement>
## Motivation
<why needed>

## Requirements
<specific requirements or "TBD">
</if>

---
*Created via Claude Code `/issue` command*
EOF
)" \
  --label "<label>"
```

### 6. Display Result

After successful creation:
```
Issue created successfully!

  #<number>: <title>
  URL: https://github.com/<owner>/<repo>/issues/<number>
  Labels: <labels>
```

## Error Handling

### GitHub CLI not authenticated
```
Error: gh CLI not authenticated.
Run: gh auth login
```

### No git repository
```
Error: Not in a git repository.
Navigate to a repo directory and try again.
```

### Label doesn't exist
```
Warning: Label 'bug' not found in repo.
Creating issue without label. You can add labels manually at:
https://github.com/<owner>/<repo>/issues/<number>
```

### Title required
If no title provided and user cancels interactive prompt:
```
Error: Issue title is required.
Usage: /issue [type] [title]
```

## Tips

1. **Quick bug reports**: `/issue bug <title>` creates a bug issue immediately with minimal prompts
2. **Context is automatic**: You don't need to copy-paste branch names or commits
3. **Labels are optional**: If the label doesn't exist, the issue still gets created
4. **Edit after creation**: The URL is shown so you can add more details in GitHub UI

## Related Commands

- `/createpr` - Create a pull request
- `/postprcleanup` - Clean up after PR merge
