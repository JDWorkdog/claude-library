---
name: onboard
description: Generate codebase overview for new team members
---

# /onboard Command

Generate comprehensive codebase documentation for new team members.

## Usage

```
/onboard                   # Full codebase overview
/onboard --quick           # Quick 5-minute overview
/onboard --area <name>     # Deep dive into specific area
/onboard --patterns        # Focus on coding patterns used
```

## Process

### Full Onboarding (`/onboard`)

1. **Project Overview**
   - Read package.json, CLAUDE.md, README.md
   - Identify tech stack and purpose

2. **Architecture Survey**
   - Map directory structure
   - Identify key boundaries (client/server)
   - Document major patterns

3. **Core Flows**
   - Trace a request from UI to database
   - Explain authentication flow
   - Show data fetching patterns

4. **Development Workflow**
   - List available commands
   - Explain testing approach
   - Document deployment process

5. **Key Files Reference**
   - Critical files to understand first
   - Where to find common things

### Quick Overview (`--quick`)

Condensed version covering:
- What the project does
- Tech stack at a glance
- How to run locally
- Where to start reading code

### Area Deep Dive (`--area`)

Available areas:
- `api` - tRPC procedures, API routes
- `auth` - Authentication setup
- `db` - Database schema, patterns
- `ui` - React components, styling
- `test` - Testing patterns and setup

### Patterns Focus (`--patterns`)

Document the coding conventions:
- tRPC procedure patterns
- React component patterns
- Error handling patterns
- State management patterns

## Output Format

### Full Onboarding Document

```markdown
# Codebase Onboarding Guide

## Overview

### What This Project Does
[Brief description]

### Tech Stack
| Layer | Technology |
|-------|------------|
| Frontend | [Framework, libraries] |
| API | [API framework] |
| Auth | [Auth solution] |
| Database | [Database and ORM] |
| Deployment | [Platform] |

## Architecture

### System Diagram
```mermaid
[Component diagram]
```

### Directory Structure
```
src/
├── app/           # Pages and routing
├── server/        # Backend logic
├── components/    # React components
└── lib/           # Utilities
```

### Key Patterns
[Documented patterns with examples]

## Getting Started

### Prerequisites
- [Required software]

### Local Setup
```bash
[Setup commands]
```

### Key Commands
| Command | Purpose |
|---------|---------|
| `npm run dev` | Start development |
| `npm test` | Run tests |
| `npm run build` | Production build |

## Core Flows

### Request Lifecycle
[Sequence diagram and explanation]

### Authentication Flow
[How auth works in this project]

## Where to Start

### First Files to Read
1. [File] - [Why]
2. [File] - [Why]

### Making Your First Change
[Step-by-step guide]

## Conventions

### Code Style
[Key conventions]

### Git Workflow
[Branch and commit conventions]

## Resources

- [Links to relevant docs]
```

### Quick Overview Output

```markdown
# Quick Start: [Project Name]

## What It Is
[One paragraph description]

## Stack
[Technology summary]

## Run Locally
```bash
[Commands]
```

## Key Files
- [File] - [Purpose]

## Common Tasks
- Add API endpoint: [Location]
- Add page: [Location]
- Add component: [Location]
```

## Tips for New Developers

1. **Start with the schema** - Database schema shows the data model
2. **Trace a feature** - Pick one feature and follow it end-to-end
3. **Run the tests** - Tests are documentation
4. **Ask the AI** - Use `/explain` for any confusing code
5. **Check CLAUDE.md** - Project conventions are documented there
