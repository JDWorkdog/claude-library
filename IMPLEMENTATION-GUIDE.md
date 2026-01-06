# Claude Library Implementation Guide

This document captures the full context for completing the claude-library setup. It can be used by any agent to continue the work.

## Project Purpose

Create a shareable GitHub repository (`claude-library`) containing:
- Personal-level Claude components (agents, skills, commands, hooks)
- Project templates with .claude/ configurations
- GitHub Actions workflow templates
- Installation scripts for both symlink and copy methods

## Repository Location

`/Users/johnworkman/Documents/Projects/claude-library/`

## Source Projects for Components

| Project | Path | Content |
|---------|------|---------|
| claude-dev-environment | `/Users/johnworkman/Documents/Projects/claude-dev-environment/.claude/` | 11 engineering agents, 6 commands, 5 skills |
| Workdog-DesktopAI | `/Users/johnworkman/Documents/Projects/Workdog-DesktopAI/.claude/` | 4 productivity agents, 24 commands |
| daily-grind | `/Users/johnworkman/Documents/Projects/daily-grind/.claude/` | 4 productivity agents, 7 commands |
| adhoc_agent_to_slides | `/Users/johnworkman/Documents/Projects/adhoc_agent_to_slides/.claude/` | 19 analysis agents (extract patterns only) |

## Component Decisions (from docs/decisions.md)

### Agents to Copy

**From claude-dev-environment (copy all):**
- architecture-advisor.md
- code-reviewer.md
- data-engineer.md
- database-specialist.md
- devops-cicd.md
- documentation-writer.md
- frontend-ux-expert.md
- incident-responder.md
- orchestrator.md → rename to engineering-manager.md
- security-scanner.md
- test-engineer.md

**From Workdog-DesktopAI:**
- daily-planning-agent.md → rename to daily-planner.md
- document-quality-agent.md → rename to document-quality.md
- meeting-prep-agent.md → rename to meeting-prep.md
- research-agent.md (compare with daily-grind version)

**From daily-grind:**
- context-builder.md
- personal-assistant.md
- research.md → use as research-agent.md (more detailed, 155 lines)
- task-decomposer.md

### Commands to Copy

**From claude-dev-environment:**
- commit.md
- explain.md
- onboard.md
- review.md
- security.md
- test.md

**From daily-grind (preferred over Workdog):**
- daily.md (more general, has "What Did I Do?" feature)
- add-task.md
- brainstorm.md
- prd.md
- prompt.md
- research.md
- review-tasks.md

### Skills to Copy

**From claude-dev-environment:**
- code-review/
- test-generation/
- security-audit/
- code-explanation/
- pr-creation/

### Hooks to Create (new)

Create these in `personal/hooks/`:

**session-start.sh:**
```bash
#!/bin/bash
# Validate common development environment
echo "🔍 Checking environment..."
if ! command -v git &> /dev/null; then
    echo "⚠️  WARNING: git not found"
fi
if command -v node &> /dev/null; then
    echo "✅ Node $(node --version)"
else
    echo "⚠️  WARNING: node not found"
fi
echo "✅ Session started"
```

**pre-bash-safety.sh:**
```bash
#!/bin/bash
# Warn before dangerous commands
COMMAND="$CLAUDE_TOOL_INPUT"
if [[ "$COMMAND" =~ "rm -rf /" ]] || [[ "$COMMAND" =~ "rm -rf ~" ]]; then
    echo "🛑 BLOCKED: Refusing to delete root or home directory"
    exit 1
fi
if [[ "$COMMAND" =~ "git push --force" ]] || [[ "$COMMAND" =~ "git push -f" ]]; then
    echo "⚠️  WARNING: Force push detected. Proceed with caution."
fi
if [[ "$COMMAND" =~ "DROP TABLE" ]] || [[ "$COMMAND" =~ "drop table" ]]; then
    echo "⚠️  WARNING: DROP TABLE detected. Are you sure?"
fi
exit 0
```

**pre-write-safety.sh:**
```bash
#!/bin/bash
# Warn before writing to protected files
FILE_PATH="$CLAUDE_FILE_PATH"
PROTECTED_PATTERNS=(".env" "credentials" "*.pem" "*.key" "secrets" "package-lock.json")
for pattern in "${PROTECTED_PATTERNS[@]}"; do
    if [[ "$FILE_PATH" == *"$pattern"* ]]; then
        echo "⚠️  WARNING: Writing to protected file: $FILE_PATH"
        break
    fi
done
exit 0
```

### Settings.json Template

Create `personal/settings.json`:
```json
{
  "hooks": {
    "SessionStart": {
      "command": "~/.claude/hooks/session-start.sh",
      "description": "Validate environment on session start"
    },
    "PreToolUse": [
      {
        "command": "~/.claude/hooks/pre-bash-safety.sh",
        "description": "Warn before dangerous bash commands",
        "toolFilter": ["Bash"]
      },
      {
        "command": "~/.claude/hooks/pre-write-safety.sh",
        "description": "Warn before writing protected files",
        "toolFilter": ["Write", "Edit"]
      }
    ]
  }
}
```

## Project Templates to Create

### nextjs-trpc template
Copy from claude-dev-environment and generalize:
- `.claude/CLAUDE.md` - Generic Next.js/tRPC guidance
- `.claude/settings.json` - Project settings
- `.github/workflows/` - CI/CD workflows

### python-notebook template
Create new for data science projects:
- `.claude/CLAUDE.md` - Jupyter/Python guidance
- `.claude/settings.json` - Python project settings

### data-analysis template
Extract patterns from adhoc_agent_to_slides:
- `.claude/CLAUDE.md` - Analysis pipeline guidance
- Generic QC patterns (not domain-specific)

## GitHub Actions to Create

In `github-actions/`:
- code-review.yml - Automated PR review
- security-scan.yml - Security vulnerability scanning
- test-coverage.yml - Test execution and coverage
- claude-assistant.yml - @claude mention handler

## Remaining Tasks

1. Copy agents from source projects to `personal/agents/`
2. Copy skills from claude-dev-environment to `personal/skills/`
3. Copy commands from source projects to `personal/commands/`
4. Create hook scripts in `personal/hooks/`
5. Create `personal/settings.json`
6. Create project templates in `project/templates/`
7. Create GitHub Actions in `github-actions/`
8. Initialize git repository

## File Naming Conventions

- **Agents**: Function-first naming (code-reviewer, not engineering-code-reviewer)
- **Commands**: Lowercase, hyphenated (review, daily-plan)
- **Skills**: Hyphenated folders (code-review/, test-generation/)
- **Hooks**: Descriptive with .sh extension (pre-bash-safety.sh)

## Generalization Rules

When copying components:
1. Remove project-specific paths (e.g., `projects/journal/` → generic)
2. Change first-person ("my") to third-person ("the user's")
3. Remove tool-specific references unless generic (e.g., "Prisma" → "ORM")
4. Add YAML frontmatter with version, description, author
