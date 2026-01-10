# Skills Documentation

This directory contains documentation for all skills in the Claude Library.

## Overview

Skills are specialized capabilities that Claude can invoke to perform specific tasks. Unlike agents (which are delegated to), skills are invoked as part of the main conversation flow.

## Available Skills

| Skill | Description | Invocation |
|-------|-------------|------------|
| [code-review](code-review.md) | Comprehensive code reviews | Automatic when reviewing code |
| [test-generation](test-generation.md) | Generate tests for TypeScript/React | "Generate tests for..." |
| [security-audit](security-audit.md) | OWASP-based security scanning | "Run a security audit" |
| [code-explanation](code-explanation.md) | Explain code and architecture | "Explain this code..." |
| [pr-creation](pr-creation.md) | Create PRs with conventional commits | "Create a PR for..." |
| [ralph-prd](ralph-prd.md) | Generate PRDs for Ralph Loop | "Create a Ralph PRD..." |

## Skill Details

### code-review

Performs comprehensive code reviews checking:
- Code style and conventions
- Complexity and maintainability
- Security vulnerabilities
- Performance issues
- Best practices

**Output format:** Structured feedback with severity levels (BLOCKER, MAJOR, MINOR, SUGGESTION)

### test-generation

Generates tests for TypeScript and React code:
- Unit tests with Vitest
- Component tests with React Testing Library
- Integration tests for tRPC procedures
- E2E test scaffolding

**Target coverage:** 80% for new code

### security-audit

OWASP-based security scanning:
- Injection vulnerabilities (SQL, XSS, Command)
- Authentication issues
- Authorization flaws
- Sensitive data exposure
- Security misconfigurations

**Output format:** Vulnerability report with severity and remediation steps

### code-explanation

Explains code, architecture, and patterns:
- Function-by-function explanations
- Data flow diagrams (Mermaid)
- Architecture overviews
- Pattern identification

**Output format:** Prose explanations, diagrams, annotated code

### pr-creation

Creates pull requests with:
- Conventional commit messages
- Comprehensive PR descriptions
- Summary of changes
- Test plan checklist

### ralph-prd

Generates PRDs optimized for Ralph Loop autonomous execution:
- Automated verification steps (tests, builds, linters)
- Phased implementation with checkpoints
- Explicit non-goals to prevent scope creep
- Machine-verifiable completion criteria
- Completion signal for loop termination

**Triggers:** "ralph", "autonomous", "iterative development", "Ralph PRD"

## How Skills Work

### Automatic Invocation

Skills are invoked automatically when Claude detects relevant tasks:

```
User: Generate unit tests for the UserService class
Claude: [Invokes test-generation skill]
```

### Explicit Invocation

You can also invoke skills via slash commands:

```
/test              # Invokes test-generation
/review            # Invokes code-review
/security          # Invokes security-audit
```

## Skill File Format

Skills are defined in folders with a `SKILL.md` file:

```
personal/skills/skill-name/
├── SKILL.md        # Main skill definition
├── templates/      # Optional templates
└── scripts/        # Optional scripts
```

The `SKILL.md` file contains:

```markdown
---
name: skill-name
description: What this skill does
version: 1.0.0
triggers:
  - "generate tests"
  - "create tests"
---

# Skill Name

Instructions for the skill...
```

## Adding New Skills

See [CONTRIBUTING.md](../../CONTRIBUTING.md) for guidelines on adding new skills.
