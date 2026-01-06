# Commands Documentation

This directory contains documentation for all slash commands in the Claude Library.

## Overview

Commands are shortcuts that expand into detailed prompts when invoked with a slash (`/`). They provide quick access to common workflows.

## Available Commands

| Command | Description | Usage |
|---------|-------------|-------|
| [/review](review.md) | Run code review | `/review` or `/review src/components/` |
| [/test](test.md) | Run or generate tests | `/test` or `/test UserService` |
| [/security](security.md) | Run security audit | `/security` |
| [/commit](commit.md) | Generate conventional commit | `/commit` |
| [/explain](explain.md) | Explain code or architecture | `/explain src/auth/` |
| [/onboard](onboard.md) | Generate codebase overview | `/onboard` |
| [/daily](daily.md) | Start daily planning workflow | `/daily` |
| [/research](research.md) | Research a topic | `/research "topic"` |
| [/prd](prd.md) | Generate PRD document | `/prd "feature name"` |

## Development Commands

### /review

Performs comprehensive code review on changed files or specified paths.

```
/review                    # Review all changed files
/review src/components/    # Review specific directory
/review --staged          # Review only staged changes
```

### /test

Runs existing tests or generates new tests.

```
/test                     # Run all tests
/test UserService         # Generate tests for UserService
/test --coverage          # Run with coverage report
```

### /security

Runs security audit following OWASP guidelines.

```
/security                 # Full security audit
/security src/api/        # Audit specific directory
```

### /commit

Generates a conventional commit message from staged changes.

```
/commit                   # Generate commit for staged changes
```

### /explain

Explains code, architecture, or patterns.

```
/explain src/auth/        # Explain auth system
/explain "data flow"      # Explain data flow
```

### /onboard

Generates a codebase overview for new team members.

```
/onboard                  # Full codebase overview
```

## Productivity Commands

### /daily

Starts the daily planning workflow.

```
/daily                    # Start daily planning
```

Includes:
- Task inventory
- Priority alignment
- Time blocking suggestions

### /research

Researches a topic using web search and synthesis.

```
/research "Claude Code hooks"
/research "React 19 features"
```

### /prd

Generates a Product Requirements Document.

```
/prd "User authentication"
/prd "Dark mode feature"
```

## Command File Format

Commands are defined as Markdown files:

```markdown
---
name: command-name
description: Brief description
version: 1.0.0
---

# /command-name

When the user runs this command, do the following:

1. Step one...
2. Step two...
```

## Adding New Commands

See [CONTRIBUTING.md](../../CONTRIBUTING.md) for guidelines on adding new commands.

## Tips

### Command Arguments

Most commands accept arguments:

```
/review src/             # Argument: path to review
/test UserService        # Argument: class to test
/research "query"        # Argument: research topic
```

### Chaining Commands

You can run multiple commands in sequence:

```
User: /review then /commit
Claude: [Runs review, then generates commit]
```

### Command Help

Add `--help` to see command usage:

```
/review --help
```
