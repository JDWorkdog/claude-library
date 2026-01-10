# Workflow Guides

This directory contains guides for advanced Claude Code workflows and automation patterns.

## Available Guides

### Ralph Wiggum (Autonomous Iteration)

Ralph Wiggum is a Claude Code plugin that runs iterative loops, feeding Claude the same prompt repeatedly until a task is complete. Ideal for autonomous, long-running tasks with automated verification.

| Guide | Description |
|-------|-------------|
| [Overview](ralph-wiggum-overview.md) | What Ralph Wiggum is, how it works, philosophy |
| [Installation](ralph-wiggum-installation.md) | Installing at user-level for all projects |
| [Usage](ralph-wiggum-usage.md) | Preparing tasks, writing prompts, running loops |

### Engineering Manager (Orchestrated Delegation)

The Engineering Manager agent coordinates development tasks by delegating to specialist agents. Best for bounded tasks requiring human oversight and multi-specialist coordination.

| Guide | Description |
|-------|-------------|
| [Engineering Manager Guide](engineering-manager-guide.md) | When to use, how to trigger, input requirements |

## Quick Comparison

| Aspect | Ralph Wiggum | Engineering Manager |
|--------|--------------|---------------------|
| **Best for** | Autonomous iteration | Coordinated tasks |
| **Duration** | Hours to days | Minutes to hours |
| **Human involvement** | Set and forget | Can intervene anytime |
| **Verification** | Must be automated | Human can review |
| **Design decisions** | Predetermined | Can ask mid-task |

## Which Should I Use?

**Choose Ralph Wiggum when:**
- You have clear, automated verification (tests, builds)
- You can walk away and check back later
- The task benefits from iteration (TDD, refactoring)
- Requirements are fully defined upfront

**Choose Engineering Manager when:**
- You want visibility into the work
- Design decisions may arise
- Multiple specialists need coordination
- You want to review before committing

## Related Commands

| Command | Description |
|---------|-------------|
| `/ralph-prd` | Generate a PRD optimized for Ralph Loop execution |
| `/prd` | Generate a standard PRD for human review |

Use `/ralph-prd` when you plan to run the feature through Ralph Loop - it includes automated verification steps, phased implementation, and explicit completion criteria.

## Getting Started

1. **New to both?** Start with the [Engineering Manager Guide](engineering-manager-guide.md) - it's simpler to use
2. **Want autonomous execution?** Read the [Ralph Wiggum Overview](ralph-wiggum-overview.md) first
3. **Ready to install Ralph?** Follow the [Installation Guide](ralph-wiggum-installation.md)
4. **Planning a Ralph task?** Use `/ralph-prd` to generate an optimized PRD
