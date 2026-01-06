# Component Decisions

This document tracks decisions made when consolidating duplicate components from multiple projects.

## Duplicate Analysis

### Daily Planning Agents

| Source | Component | Lines | Features |
|--------|-----------|-------|----------|
| Workdog-DesktopAI | daily-planning-agent | 118 | Journal review, priority assessment, action plan |
| daily-grind | context-builder | 120 | Session briefing, recent activity summary |
| daily-grind | task-decomposer | 145 | Complex task breakdown, dependencies, sizing |

**Decision:** Include all three as separate agents - they serve distinct purposes:
- `daily-planner.md` ← from daily-planning-agent (morning planning focus)
- `context-builder.md` ← from daily-grind (session context recovery)
- `task-decomposer.md` ← from daily-grind (task breakdown)

**Rationale:** These aren't truly duplicates - they address different moments in the workflow. Daily planner is for morning prioritization, context-builder is for resuming work, and task-decomposer is for breaking down complex work.

---

### Research Agents

| Source | Component | Lines | Features |
|--------|-----------|-------|----------|
| Workdog-DesktopAI | research-agent | 98 | Multi-source investigation, citations, structured reports |
| daily-grind | research | 155 | Deep research, background execution, comprehensive synthesis |

**Decision:** Use daily-grind `research.md` as base → `research-agent.md`

**Rationale:** The daily-grind version is more detailed (155 vs 98 lines) and includes background execution capability. Will generalize the name to `research-agent.md` for consistency with function-first naming.

---

### Daily Commands

| Source | Component | Lines | Features |
|--------|-----------|-------|----------|
| Workdog-DesktopAI | daily.md | 83 | First-person ("my"), detailed date handling, specific paths |
| daily-grind | daily.md | 90 | Third-person (general), "What Did I Do?" feature, cleaner |

**Decision:** Use daily-grind `daily.md` as base

**Rationale:** daily-grind version is more general (not first-person "my"), cleaner structure, and has the "What Did I Do?" feature. Both are similar in functionality, but daily-grind is better for sharing.

---

### Review Commands

| Source | Component | Lines | Features |
|--------|-----------|-------|----------|
| claude-dev-environment | review.md | 66 | Code review focus, severity classification |

**Decision:** Use claude-dev-environment `review.md`

**Rationale:** Only version found in the diff - it's specifically for code review with severity classification.

---

## Decision Criteria

When choosing between duplicates, we evaluate:

1. **Comprehensiveness** - Which covers more use cases?
2. **Specificity** - Which has better examples/patterns?
3. **Maintainability** - Which is easier to update?
4. **Documentation** - Which is better documented?
5. **Tested** - Which has been used more in practice?
6. **Generalizability** - Which is more sharable (less project-specific)?

## Merge Strategy

When merging components:

1. Start with the more comprehensive version as base
2. Add unique features from other versions
3. Remove project-specific references
4. Generalize first-person language ("my" → "the user's")
5. Add version number and changelog
6. Document the merge in this file
