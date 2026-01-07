# Installation Guide

This guide covers all installation methods and configuration options for the Claude Library.

## System Requirements

- **Operating System**: macOS, Linux, or Windows with WSL
- **Claude Code**: Latest version of Claude Code CLI
- **Git**: For cloning and updating the library
- **Bash**: For running installation scripts

## Installation Methods

### Method 1: Symlink Installation

Creates symbolic links from `~/.claude/` to the library repository.

```bash
./scripts/install.sh
```

**What it does:**
1. Backs up existing `~/.claude/` configuration (if any)
2. Creates symlinks for `agents/`, `skills/`, `commands/`, `hooks/`
3. Merges `settings.json` with existing settings
4. Makes hook scripts executable

**Directory structure after installation:**
```
~/.claude/
├── agents -> /path/to/claude-library/personal/agents
├── skills -> /path/to/claude-library/personal/skills
├── commands -> /path/to/claude-library/personal/commands
├── hooks -> /path/to/claude-library/personal/hooks
└── settings.json (merged)
```

### Method 2: Copy Installation

Copies files directly to `~/.claude/`.

```bash
./scripts/install-copy.sh
```

**What it does:**
1. Backs up existing `~/.claude/` configuration (if any)
2. Copies all files from `personal/` to `~/.claude/`
3. Merges `settings.json` with existing settings
4. Makes hook scripts executable

### Method 3: Manual Installation

For full control, manually copy specific components:

```bash
# Copy specific agents
cp claude-library/personal/agents/code-reviewer.md ~/.claude/agents/

# Copy specific commands
cp claude-library/personal/commands/review.md ~/.claude/commands/

# Copy a skill
cp -r claude-library/personal/skills/code-review/ ~/.claude/skills/
```

## Updating

### Symlink Installation

Simply pull the latest changes:

```bash
cd /path/to/claude-library
git pull
```

Changes are immediately available.

### Copy Installation

Run the update script:

```bash
./scripts/update.sh
```

This will:
1. Show what files have changed
2. Ask for confirmation before updating
3. Backup current configuration
4. Copy new files

## Configuration

### Settings File

The `personal/settings.json` contains recommended settings including hooks:

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

### Customizing Components

#### Local Overrides

Create local override files that won't be tracked:

```bash
# Create a local settings override
cp ~/.claude/settings.json ~/.claude/settings.local.json
# Edit settings.local.json with your customizations
```

#### Forking Components

To customize an agent while keeping the original:

```bash
# Copy and rename
cp ~/.claude/agents/code-reviewer.md ~/.claude/agents/my-code-reviewer.md
# Edit my-code-reviewer.md with customizations
```

### Disabling Components

#### Disable Specific Hooks

Edit `~/.claude/settings.json` and remove the hook from the `hooks` section.

#### Disable Specific Agents

Simply delete or rename the agent file:

```bash
mv ~/.claude/agents/some-agent.md ~/.claude/agents/some-agent.md.disabled
```

## GitHub Actions

The `github-actions/` folder contains workflow templates for CI/CD automation with Claude Code.

### Installing a Workflow

Copy the desired workflow to your project's `.github/workflows/` directory:

```bash
# Copy a single workflow
cp claude-library/github-actions/code-review.yml your-project/.github/workflows/

# Or copy all workflows
cp claude-library/github-actions/*.yml your-project/.github/workflows/
```

### Available Workflows

| Workflow | Trigger | Description |
|----------|---------|-------------|
| `code-review.yml` | PR to main/develop | Automated code review with severity levels |
| `security-scan.yml` | PR, weekly schedule | Security vulnerability scanning |
| `test-coverage.yml` | PR, push | Test execution and coverage reporting |
| `claude-assistant.yml` | @claude mention | Respond to mentions in PRs/issues |
| `issue-worker.yml` | Issue created/labeled | Auto-implement issues created via `/issue` command |

### Required Secrets

All workflows require the `ANTHROPIC_API_KEY` secret. Add it to your repository:

1. Go to your repo → Settings → Secrets and variables → Actions
2. Click "New repository secret"
3. Name: `ANTHROPIC_API_KEY`
4. Value: Your Anthropic API key

### Issue Worker Setup

The `issue-worker.yml` workflow requires additional labels in your repository for state management.

**Create the required labels:**

```bash
# Run these commands in your project repository
gh label create claude-autowork --color 0E8A16 --description "Trigger Claude to implement this issue"
gh label create claude-dryrun --color 1D76DB --description "Claude analyzes but doesn't implement"
gh label create claude-working --color FBCA04 --description "Claude is currently working on this"
gh label create claude-implemented --color 0E8A16 --description "Claude created a PR for this issue"
gh label create claude-failed --color D93F0B --description "Claude failed to implement this issue"
```

**How it works:**
1. Create an issue using the `/issue` command (auto-adds `claude-autowork` label by default)
2. The workflow triggers and adds `claude-working` label
3. Claude analyzes the issue and posts an implementation plan
4. If complexity is simple/moderate, Claude implements and creates a PR
5. On success: `claude-implemented` label added, PR linked to issue
6. On failure: `claude-failed` label added with error details

**Dry-run mode:** Add `claude-dryrun` label (instead of `claude-autowork`) to get an analysis without implementation.

## Project Templates

### Installing a Template

Use the init script to create a new project with a template:

```bash
./scripts/init-project.sh <template-name> <project-directory>
```

**Available templates:**
- `nextjs-trpc` - Next.js 15 with tRPC, Prisma, Tailwind
- `python-notebook` - Jupyter notebook with data science libs
- `data-analysis` - Complex data analysis pipeline

### Creating Custom Templates

1. Copy an existing template:
   ```bash
   cp -r project/templates/nextjs-trpc project/templates/my-template
   ```

2. Customize the `.claude/` configuration

3. Update `project/templates/my-template/.claude/CLAUDE.md` with project-specific instructions

## Uninstallation

### Remove Symlinks

```bash
rm ~/.claude/agents ~/.claude/skills ~/.claude/commands ~/.claude/hooks
```

### Remove Copied Files

```bash
rm -rf ~/.claude/agents ~/.claude/skills ~/.claude/commands ~/.claude/hooks
```

### Restore Backup

If installation created a backup:

```bash
cp -r ~/.claude.backup/* ~/.claude/
```

## Troubleshooting

### Permission Denied on Hooks

```bash
chmod +x ~/.claude/hooks/*.sh
```

### Broken Symlinks

Check if the library repository was moved:

```bash
ls -la ~/.claude/agents
# If broken, re-run install.sh from the new location
```

### Merge Conflicts in Settings

The installation scripts attempt to merge settings. If conflicts occur:

1. Backup your current settings: `cp ~/.claude/settings.json ~/.claude/settings.backup.json`
2. Re-run installation
3. Manually merge any custom settings from your backup

### Components Not Recognized

1. Restart Claude Code
2. Verify files exist: `ls ~/.claude/agents/`
3. Check file permissions: `ls -la ~/.claude/agents/`
