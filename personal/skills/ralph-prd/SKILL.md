---
name: ralph-prd
description: Generate Product Requirements Documents optimized for autonomous execution via Ralph Loop. Use when planning features that will be implemented by Ralph Loop, or when the user wants to create a PRD specifically for iterative AI development.
allowed-tools: Read, Grep, Glob, Write
---

# Ralph PRD Skill

Generate PRDs optimized for autonomous execution via Ralph Loop. These PRDs include automated verification, phased implementation, and explicit completion criteria.

## When to Use

- User wants to plan a feature for Ralph Loop execution
- User mentions "ralph", "autonomous", "iterative development"
- User wants a PRD with verification steps
- User asks for a "machine-readable" or "automatable" PRD

## Key Differences from Standard PRD

| Standard PRD | Ralph PRD |
|--------------|-----------|
| Human reviews completion | Automated verification commands |
| Success metrics (KPIs) | Completion criteria (tests pass) |
| Timeline estimates | Phased implementation with checkpoints |
| Open-ended scope | Explicit non-goals to prevent scope creep |
| Implicit done state | Explicit completion signal |

## PRD Generation Process

### 1. Gather Context
- Read relevant existing code files
- Identify testing framework and patterns
- Find existing verification commands (package.json scripts)
- Understand project conventions

### 2. Ask Clarifying Questions
Focus on verification and completion:
```
1. Verification commands? (npm test, npm run build, etc.)
2. Test coverage target? (70%, 80%, 90%)
3. What's explicitly out of scope?
4. Existing patterns to follow?
```

### 3. Generate Ralph PRD Structure

```markdown
# Ralph PRD: [Feature Name]

## Overview
[One sentence goal]

## Context
- Existing code/patterns to build on
- Technology constraints
- Key files to reference

## Requirements
1. [Requirement]
   - Verification: [How to verify]

## Non-Goals
- [What NOT to do - critical for preventing scope creep]

## Implementation Phases
### Phase 1: [Name]
- Tasks
- **Verification**: [Command]

### Phase 2: [Name]
- Tasks
- **Verification**: [Command]

## Verification Commands
```bash
npm run typecheck
npm test
npm run build
```

## Completion Criteria
- [ ] Checklist items

## Completion Signal
Output <promise>COMPLETE</promise> when all criteria verified.
```

## Verification Patterns

### For TypeScript Projects
```bash
npm run typecheck    # No type errors
npm test             # All tests pass
npm run build        # Production build succeeds
```

### For Python Projects
```bash
mypy .               # Type checking
pytest               # All tests pass
python -m build      # Build succeeds
```

### For Go Projects
```bash
go vet ./...         # Static analysis
go test ./...        # All tests pass
go build ./...       # Build succeeds
```

## Non-Goals Section (Critical)

The Non-Goals section is essential for Ralph Loop. Without clear boundaries, Claude may:
- Scope creep into related features
- Attempt optimizations not requested
- Refactor unrelated code

Always include explicit non-goals like:
- "Do NOT modify existing tests"
- "Do NOT refactor unrelated code"
- "Do NOT add features beyond the requirements"
- "Do NOT change database schema unless specified"

## Output File

Save as: `ralph-prd-[feature-name].md`

## After Generation

1. Review verification commands with user
2. Confirm non-goals are complete
3. Validate completion criteria are measurable
4. Offer to start Ralph Loop:
   ```
   @ralph-loop "$(cat ralph-prd-[feature-name].md)"
   ```

## Example Questions to Ask

```
1. What verification commands should pass when complete?
   A. npm test && npm run build
   B. npm test && npm run typecheck && npm run build
   C. npm test && npm run lint && npm run typecheck && npm run build
   D. Custom (please specify)

2. What test coverage target should be met?
   A. Any passing tests
   B. 70% coverage on new code
   C. 80% coverage on new code
   D. 90%+ coverage on new code
```

## Quality Checklist

Before finalizing, verify:
- [ ] Every requirement has a verification method
- [ ] Non-goals explicitly list what to avoid
- [ ] Phases have clear verification checkpoints
- [ ] Completion criteria are machine-verifiable
- [ ] Completion signal is included
