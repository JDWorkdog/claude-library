# Hooks Documentation

This directory contains documentation for all hooks in the Claude Library.

## Overview

Hooks are shell scripts that run automatically at specific points in the Claude Code lifecycle. They provide safety guardrails, environment validation, and consistency enforcement.

## Available Hooks

| Hook | Trigger | Purpose |
|------|---------|---------|
| [session-start.sh](session-start.md) | Session start | Validate environment |
| [pre-bash-safety.sh](pre-bash-safety.md) | Before Bash commands | Warn on dangerous commands |
| [pre-write-safety.sh](pre-write-safety.md) | Before Write/Edit | Warn on protected files |

## Hook Types

### SessionStart

Runs once when Claude Code starts a new session.

**Use cases:**
- Validate development environment
- Check required tools are installed
- Verify environment variables

### PreToolUse

Runs before specific tools are executed.

**Use cases:**
- Safety warnings for dangerous operations
- Permission checks
- Logging

**Tool filters:**
- `Bash` - Before shell commands
- `Write` - Before creating files
- `Edit` - Before editing files
- `Read` - Before reading files

### PostToolUse

Runs after specific tools complete.

**Use cases:**
- Cleanup operations
- Logging and auditing
- Notifications

## Hook Details

### session-start.sh

Validates the development environment on session start.

**Checks performed:**
- Git installation and version
- Node.js installation and version
- Python installation (if applicable)
- Environment variables (ANTHROPIC_API_KEY)
- Project-specific requirements

**Output:**
```
🔍 Checking environment...
✅ Git 2.39.0
✅ Node v20.10.0
ℹ️  No ANTHROPIC_API_KEY found (using .env file)
✅ Session started
```

### pre-bash-safety.sh

Warns before executing dangerous bash commands.

**Blocked patterns:**
- `rm -rf /` or `rm -rf ~` (hard block, exit 1)

**Warning patterns:**
- `git push --force` or `git push -f`
- `DROP TABLE` or `drop table`
- `npm publish`
- `docker push`
- `rm -rf` with significant paths

**Output:**
```
⚠️  WARNING: Force push detected. Proceed with caution.
```

### pre-write-safety.sh

Warns before writing to protected files.

**Protected patterns:**
- `.env` files
- `credentials.json`, `secrets.json`
- `*.pem`, `*.key` files
- `package-lock.json`, `yarn.lock`, `pnpm-lock.yaml`

**Output:**
```
⚠️  WARNING: Writing to protected file: .env
```

## Configuration

Hooks are configured in `~/.claude/settings.json`:

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
        "description": "Warn before writing to protected files",
        "toolFilter": ["Write", "Edit"]
      }
    ]
  }
}
```

## Environment Variables

Hooks receive context via environment variables:

| Variable | Description |
|----------|-------------|
| `CLAUDE_TOOL_NAME` | Name of the tool being executed |
| `CLAUDE_TOOL_INPUT` | Input/command being executed |
| `CLAUDE_FILE_PATH` | File path (for Write/Edit/Read) |
| `CLAUDE_SESSION_ID` | Current session identifier |

## Exit Codes

| Code | Meaning |
|------|---------|
| `0` | Continue execution |
| `1` | Block execution (hard stop) |
| Other | Continue with warning |

## Creating Custom Hooks

### 1. Create the script

```bash
#!/bin/bash
# ~/.claude/hooks/my-custom-hook.sh

# Your logic here
echo "ℹ️  Custom hook executed"

exit 0  # Continue execution
```

### 2. Make it executable

```bash
chmod +x ~/.claude/hooks/my-custom-hook.sh
```

### 3. Configure in settings.json

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "command": "~/.claude/hooks/my-custom-hook.sh",
        "description": "My custom hook",
        "toolFilter": ["Bash"]
      }
    ]
  }
}
```

## Best Practices

1. **Keep hooks fast** - They run on every tool use
2. **Use warnings, not blocks** - Block only truly dangerous operations
3. **Provide clear messages** - Use emojis and clear text
4. **Log sparingly** - Avoid noisy output
5. **Test thoroughly** - Broken hooks can disrupt workflow

## Disabling Hooks

To temporarily disable a hook, remove it from `settings.json` or rename the script:

```bash
mv ~/.claude/hooks/pre-bash-safety.sh ~/.claude/hooks/pre-bash-safety.sh.disabled
```
