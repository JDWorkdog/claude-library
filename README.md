# Claude Library

A curated collection of Claude Code agents, skills, commands, and hooks for development teams.

## Overview

This library provides reusable components for [Claude Code](https://claude.ai/code), organized into:

- **Personal components** (`personal/`) - Install to `~/.claude/` for user-level availability across all projects
- **Project templates** (`project/templates/`) - Copy to new projects for quick setup
- **GitHub Actions** (`github-actions/`) - CI/CD workflow templates for Claude-powered automation

## Quick Start

### Installation

**Option 1: Symlink (recommended - auto-updates)**
```bash
./scripts/install.sh
```

**Option 2: Copy (stable - manual updates)**
```bash
./scripts/install-copy.sh
```

### Initialize a New Project

```bash
./scripts/init-project.sh nextjs-trpc my-new-project
```

## Components

### Agents (20 total)

| Category | Agents | Description |
|----------|--------|-------------|
| **Development** | engineering-manager, code-reviewer, test-engineer, security-scanner, architecture-advisor, frontend-ux-expert, devops-cicd, incident-responder | Software engineering specialists |
| **Database** | database-specialist, data-engineer | Database and data pipeline experts |
| **Productivity** | daily-planner, personal-assistant, research-agent, meeting-prep, document-quality | Personal productivity assistants |
| **Analysis** | qc-validator, multi-lens-orchestrator, fact-checker, gap-analyzer | Data analysis patterns |
| **Documentation** | documentation-writer | Technical writing specialist |

### Hooks (3 total)

| Hook | Purpose |
|------|---------|
| `session-start.sh` | Validate environment on session start |
| `pre-bash-safety.sh` | Warn before dangerous bash commands |
| `pre-write-safety.sh` | Warn before writing to protected files |

### Skills (6 total)

- `code-review/` - Comprehensive code review skill
- `test-generation/` - Generate tests for TypeScript/React
- `security-audit/` - OWASP-based security scanning
- `code-explanation/` - Explain code and architecture
- `pr-creation/` - Create PRs with conventional commits
- `ralph-prd/` - Generate PRDs optimized for Ralph Loop

### Commands (11 total)

| Command | Description |
|---------|-------------|
| `/review` | Run code review |
| `/test` | Run or generate tests |
| `/security` | Run security audit |
| `/commit` | Generate conventional commit |
| `/explain` | Explain code or architecture |
| `/onboard` | Generate codebase overview |
| `/daily` | Daily planning workflow |
| `/research` | Research a topic |
| `/prd` | Generate PRD document |
| `/ralph-prd` | Generate PRD optimized for Ralph Loop |
| `/issue` | Create GitHub issue (auto-implements via GitHub Action) |

### Project Templates

| Template | Stack | Use Case |
|----------|-------|----------|
| `nextjs-trpc` | Next.js 15, tRPC, Prisma, Tailwind | Full-stack TypeScript apps |
| `python-notebook` | Jupyter, pandas, numpy | Data science projects |
| `data-analysis` | Complex analysis pipelines | Ad-hoc data analysis |

### GitHub Actions

| Workflow | Trigger | Description |
|----------|---------|-------------|
| `code-review.yml` | PR to main/develop | Automated code review |
| `security-scan.yml` | PR, weekly schedule | Security vulnerability scan |
| `test-coverage.yml` | PR, push | Test execution and coverage |
| `claude-assistant.yml` | @claude mention | Respond to mentions in PRs/issues |
| `issue-worker.yml` | Issue created/labeled | Auto-implement issues from `/issue` command |

## Documentation

- [Getting Started](docs/getting-started.md)
- [Installation Guide](docs/installation.md)
- [Agent Documentation](docs/agents/README.md)
- [Skills Documentation](docs/skills/README.md)
- [Commands Documentation](docs/commands/README.md)
- [Hooks Documentation](docs/hooks/README.md)
- [Workflow Guides](docs/guides/README.md) - Ralph Loop, Engineering Manager

### Ralph Loop (Autonomous Iteration)

Ralph Loop is a Claude Code plugin for autonomous, iterative development. It feeds Claude the same prompt repeatedly until a task is complete, with each iteration building on previous work.

| Guide | Description |
|-------|-------------|
| [Overview](docs/guides/ralph-wiggum-overview.md) | What it is, how it works, philosophy |
| [Installation](docs/guides/ralph-wiggum-installation.md) | Install via official marketplace |
| [Usage](docs/guides/ralph-wiggum-usage.md) | Preparing tasks, writing prompts |

**Quick start:**
```bash
# 1. Install the plugin
/plugin  # Search "ralph", install ralph-loop

# 2. Create a Ralph-optimized PRD
/ralph-prd "user authentication"

# 3. Run the loop
@ralph-loop "$(cat ralph-prd-user-authentication.md)"
```

## Directory Structure

```
claude-library/
├── docs/                    # Documentation
├── personal/                # User-level components (~/.claude/)
│   ├── agents/              # Agent definitions
│   ├── skills/              # Skill definitions
│   ├── commands/            # Command definitions
│   └── hooks/               # Hook scripts
├── project/                 # Project-level components
│   ├── templates/           # Project templates
│   └── examples/            # Example configurations
├── github-actions/          # Reusable GH Action workflows
└── scripts/                 # Installation and utility scripts
```

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines on adding or modifying components.

## License

MIT License - see [LICENSE](LICENSE) for details.

## Changelog

See [CHANGELOG.md](CHANGELOG.md) for version history.
