---
name: explain
description: Explain code, architecture, or patterns for better understanding
---

# /explain Command

Explain code sections, trace data flows, and document architecture.

## Usage

```
/explain                    # Explain selected code or current file
/explain <file>            # Explain a specific file
/explain <file>:<line>     # Explain code at specific location
/explain --flow <feature>  # Trace data flow for a feature
/explain --arch            # Architecture overview
/explain --why <code>      # Explain design decisions
```

## Process

### For Code Explanation

1. **Read the target code** - Load the specified file/section
2. **Analyze context** - Find related imports, usages, and dependencies
3. **Identify patterns** - Recognize design patterns and conventions
4. **Generate explanation** with:
   - Purpose (what it does)
   - Mechanism (how it works)
   - Reasoning (why it's designed this way)
   - Usage examples

### For Data Flow (`--flow`)

1. **Identify entry point** - User action or API call
2. **Trace through layers**:
   - UI Component
   - tRPC procedure call
   - Backend handler
   - Database operation
   - Response path
3. **Generate sequence diagram** (Mermaid)
4. **Document each step** with file:line references

### For Architecture (`--arch`)

1. **Survey project structure** - Key directories and files
2. **Identify boundaries** - Client/server, modules, layers
3. **Map dependencies** - How components connect
4. **Generate component diagram** (Mermaid)
5. **Document patterns** used in the codebase

### For Design Decisions (`--why`)

1. **Identify the pattern/choice** in question
2. **Research alternatives** that could have been used
3. **Analyze trade-offs** for this codebase
4. **Document reasoning** based on:
   - Performance implications
   - Maintainability
   - Team conventions
   - Framework idioms

## Output Format

### Code Explanation
```markdown
## [File/Function Name]

### Purpose
[One-sentence summary]

### How It Works
[Step-by-step breakdown]

### Why It's Designed This Way
[Design rationale]

### Related Code
- [Links to related files]
```

### Data Flow Explanation
```markdown
## Data Flow: [Feature Name]

### User Action
[What triggers this flow]

### Flow Diagram
[Mermaid sequence diagram]

### Steps
1. **[Layer]** (`file:line`) - [Description]
2. ...

### Data Transformations
[How data changes at each step]
```

### Architecture Overview
```markdown
## Architecture Overview

### System Diagram
[Mermaid component diagram]

### Key Patterns
- **[Pattern]**: [How it's used]

### Directory Structure
[Annotated tree]

### Data Flow Summary
[High-level flow description]
```

## Examples

### Explain a tRPC Procedure
```
/explain src/server/api/routers/post.ts:create
```

### Trace Authentication Flow
```
/explain --flow authentication
```

### Understand Project Architecture
```
/explain --arch
```

## Tips

- Use `--flow` for understanding how features work end-to-end
- Use `--why` when code seems unusual or you're curious about alternatives
- Ask about specific files when onboarding to a new area
- Use `--arch` periodically to refresh mental model of the system
