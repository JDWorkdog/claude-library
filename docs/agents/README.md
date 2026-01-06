# Agent Documentation

This directory contains documentation for all agents in the Claude Library.

## Overview

Agents are specialized AI assistants that can be delegated tasks by Claude Code. Each agent has a specific focus and expertise area.

## Agent Categories

### Development Agents

Core software engineering specialists for everyday development tasks.

| Agent | Description | Use When |
|-------|-------------|----------|
| [engineering-manager](engineering-manager.md) | Orchestrates tasks and delegates to specialists | Complex multi-step tasks, feature implementation |
| [code-reviewer](code-reviewer.md) | Reviews code for quality, bugs, patterns | After code changes, before PRs |
| [test-engineer](test-engineer.md) | Generates and maintains tests | Adding tests, improving coverage |
| [security-scanner](security-scanner.md) | Scans for security vulnerabilities | Before deployment, security audits |
| [architecture-advisor](architecture-advisor.md) | Advises on system design and patterns | Planning features, technical decisions |
| [frontend-ux-expert](frontend-ux-expert.md) | UI/UX, accessibility, performance | Building UI components, UX review |
| [devops-cicd](devops-cicd.md) | Build verification, deployment | CI/CD setup, deployment issues |
| [incident-responder](incident-responder.md) | Production debugging, root cause analysis | Production issues, error investigation |

### Database Agents

Specialists for database design, queries, and data pipelines.

| Agent | Description | Use When |
|-------|-------------|----------|
| [database-specialist](database-specialist.md) | Schema design, migrations, query optimization | Database changes, performance issues |
| [data-engineer](data-engineer.md) | ETL pipelines, data transformations | Data ingestion, pipeline design |

### Productivity Agents

Personal productivity assistants for daily workflows.

| Agent | Description | Use When |
|-------|-------------|----------|
| [daily-planner](daily-planner.md) | Daily planning and task prioritization | Start of day, task organization |
| [personal-assistant](personal-assistant.md) | Personal task management | Scheduling, reminders, errands |
| [research-agent](research-agent.md) | Multi-source research and synthesis | Research tasks, information gathering |
| [meeting-prep](meeting-prep.md) | Meeting preparation and agendas | Before meetings, context gathering |
| [document-quality](document-quality.md) | Document quality assurance | Document review, consistency check |

### Analysis Agents

Patterns extracted from complex data analysis workflows.

| Agent | Description | Use When |
|-------|-------------|----------|
| [qc-validator](qc-validator.md) | Gate-based validation with structured output | Quality gates, readiness checks |
| [multi-lens-orchestrator](multi-lens-orchestrator.md) | Parallel dispatch with aggregation | Multi-perspective analysis |
| [fact-checker](fact-checker.md) | Evidence-based verification | Claim verification, accuracy checks |
| [gap-analyzer](gap-analyzer.md) | Gap identification and prioritization | Coverage analysis, missing items |

### Documentation Agents

Technical writing and documentation specialists.

| Agent | Description | Use When |
|-------|-------------|----------|
| [documentation-writer](documentation-writer.md) | Technical docs, README, JSDoc | Documentation tasks, API docs |

## How Agents Work

### Automatic Delegation

The `engineering-manager` agent can automatically delegate to specialists:

```
User: Review this PR and check for security issues
Claude: [engineering-manager delegates to code-reviewer and security-scanner]
```

### Direct Invocation

You can also request specific agents:

```
User: Use the database-specialist agent to optimize this query
Claude: [Invokes database-specialist directly]
```

### Agent Capabilities

Each agent has:
- **Specific tools**: Some agents have access to specific tools (Read, Write, Bash, etc.)
- **Model preferences**: Some use Opus for complex tasks, Haiku for simpler ones
- **Guardrails**: Built-in constraints to prevent harmful actions

## Adding New Agents

See [CONTRIBUTING.md](../../CONTRIBUTING.md) for guidelines on adding new agents.

## Agent File Format

Agents are defined as Markdown files with YAML frontmatter:

```markdown
---
name: agent-name
description: Brief description of what this agent does
version: 1.0.0
model: opus|sonnet|haiku
tools: Read, Write, Bash, Grep, Glob
---

# Agent Title

Detailed instructions for the agent...
```
