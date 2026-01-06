# Getting Started with Claude Library

This guide will help you install and start using the Claude Library components.

## Prerequisites

- [Claude Code CLI](https://claude.ai/code) installed
- Git (for cloning the repository)
- macOS, Linux, or WSL (for shell scripts)

## Installation

### 1. Clone the Repository

```bash
git clone https://github.com/yourusername/claude-library.git
cd claude-library
```

### 2. Choose Installation Method

#### Option A: Symlink Installation (Recommended)

This method creates symbolic links to the library, so updates are automatic when you pull new changes.

```bash
./scripts/install.sh
```

**Pros:**
- Automatic updates when you `git pull`
- Single source of truth
- Easy to maintain

**Cons:**
- Requires the repo to stay in place
- Changes affect all projects immediately

#### Option B: Copy Installation

This method copies files to your `~/.claude/` directory, giving you a stable snapshot.

```bash
./scripts/install-copy.sh
```

**Pros:**
- Stable - changes require manual update
- Works independently of repo location
- Can customize without affecting library

**Cons:**
- Manual updates required (`./scripts/update.sh`)
- May diverge from library over time

### 3. Verify Installation

After installation, verify the components are available:

```bash
ls ~/.claude/agents/
ls ~/.claude/commands/
ls ~/.claude/hooks/
```

## Quick Start

### Using Agents

Agents are automatically available when you start Claude Code. The engineering-manager agent can coordinate other specialists:

```
You: Help me refactor this authentication module
Claude: [Uses engineering-manager to delegate to code-reviewer and architecture-advisor]
```

### Using Commands

Commands are invoked with a slash:

```
/review          # Review code changes
/test            # Run or generate tests
/commit          # Generate conventional commit
/daily           # Start daily planning workflow
```

### Using Skills

Skills are invoked when relevant tasks are detected:

```
You: Generate tests for the UserService class
Claude: [Invokes test-generation skill automatically]
```

## Setting Up a New Project

Use the project initialization script to set up a new project with Claude configuration:

```bash
# Syntax: ./scripts/init-project.sh <template> <project-name>

# Examples:
./scripts/init-project.sh nextjs-trpc my-web-app
./scripts/init-project.sh python-notebook data-analysis-project
./scripts/init-project.sh data-analysis adhoc-research
```

This creates a new directory with:
- Pre-configured `.claude/` folder
- Project-appropriate settings
- Example CLAUDE.md

## Next Steps

- Read the [Agent Documentation](agents/README.md) to understand available agents
- Review [Hooks Documentation](hooks/README.md) to understand safety features
- Check [Commands Documentation](commands/README.md) for available slash commands
- See [Installation Guide](installation.md) for advanced configuration

## Troubleshooting

### Components Not Found

If Claude Code doesn't recognize installed components:

1. Verify installation: `ls ~/.claude/`
2. Restart Claude Code
3. Check symlinks aren't broken: `ls -la ~/.claude/agents/`

### Hook Errors

If hooks fail to execute:

1. Make them executable: `chmod +x ~/.claude/hooks/*.sh`
2. Check for syntax errors: `bash -n ~/.claude/hooks/session-start.sh`

### Need Help?

Open an issue on the repository with the `question` label.
