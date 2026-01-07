---
description: Create a GitHub issue to track bugs, enhancements, or tasks
argument-hint: [type] [title] [--no-autowork]
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
`/issue [type] [title] [--no-autowork]`

### Flags

| Flag | Default | Description |
|------|---------|-------------|
| `--autowork` | ON | Add `claude-autowork` label to trigger automatic implementation via GitHub Action |
| `--no-autowork` | - | Skip adding the autowork label (manual implementation only) |

> **Note**: By default, issues are labeled for automatic implementation. If you prefer manual-only
> issues by default, change the behavior in step 5.1 below (swap the default logic).

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
# Interactive mode (asks for details, auto-implements)
/issue

# Quick bug report (will be auto-implemented)
/issue bug Pipeline timeout on premium preset

# Enhancement suggestion (will be auto-implemented)
/issue enhancement Add retry logic to hypothesis harness

# Feature request (will be auto-implemented)
/issue feature Export analysis to Excel format

# Documentation fix (will be auto-implemented)
/issue docs Update README with new pipeline stages

# Task/todo item (will be auto-implemented)
/issue task Clean up old test fixtures

# Create issue WITHOUT auto-implementation
/issue bug Fix login redirect --no-autowork
```

## Behavior

### 1. Parse Arguments
If arguments provided:
- Check for `--no-autowork` flag and remove it from args (sets autowork=false)
- Check for `--autowork` flag and remove it from args (sets autowork=true, this is default)
- First remaining word: check if it's a known type (bug/enhancement/feature/docs/task/refactor)
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

#### 5.1 Determine Labels

Build the labels list:
```bash
LABELS="<type-label>"  # e.g., "bug", "enhancement", etc.

# AUTOWORK DEFAULT BEHAVIOR:
# By default, autowork is ON. To make manual the default, swap these conditions.
if [ "$AUTOWORK" = "true" ] || [ -z "$AUTOWORK" ]; then
  # Default: add autowork label (change to != "true" to make manual the default)
  LABELS="$LABELS,claude-autowork"
fi
```

#### 5.2 Create the Issue

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
  --label "$LABELS"
```

### 6. Display Result

After successful creation:
```
Issue created successfully!

  #<number>: <title>
  URL: https://github.com/<owner>/<repo>/issues/<number>
  Labels: <labels>
  Auto-implementation: <enabled/disabled>
```

If autowork is enabled, inform the user:
```
The Claude Issue Worker will automatically analyze this issue and create a PR.
Watch the issue for updates.
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
5. **Auto-implementation**: By default, issues trigger automatic implementation via GitHub Action
6. **Skip auto-implementation**: Use `--no-autowork` for issues you want to implement manually

## GitHub Action Integration

This command integrates with the `issue-worker.yml` GitHub Action:

1. When you create an issue (without `--no-autowork`), the `claude-autowork` label is added
2. The GitHub Action detects the label and starts analyzing the issue
3. Claude creates an implementation plan and posts it as a comment
4. If the issue is simple/moderate complexity, Claude implements it and creates a PR
5. You review and merge the PR

**Required Setup**: Ensure your repository has the `issue-worker.yml` workflow and required labels.
See the installation docs for setup instructions.

## Related Commands

- `/createpr` - Create a pull request
- `/postprcleanup` - Clean up after PR merge
