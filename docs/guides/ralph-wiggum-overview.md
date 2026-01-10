# Ralph Wiggum: Autonomous Iteration Loops

Ralph Wiggum is a Claude Code plugin that implements **iterative, self-referential AI development loops**. Named after the Simpsons character known for persistent (if misguided) optimism, it embodies the principle of "keep trying until you succeed."

## What It Is

At its core, Ralph Wiggum is remarkably simple: **a loop that feeds Claude the same prompt repeatedly until the task is complete**.

```
┌─────────────────────────────────────────────────┐
│                 Ralph Wiggum Loop                │
│                                                  │
│   ┌──────────┐                                   │
│   │  Prompt  │◄────────────────────┐             │
│   └────┬─────┘                     │             │
│        │                           │             │
│        ▼                           │             │
│   ┌──────────┐    No          ┌────┴─────┐       │
│   │  Claude  │───────────────►│ Stop Hook│       │
│   │  Works   │                │ Re-injects│       │
│   └────┬─────┘                │  Prompt   │       │
│        │                      └──────────┘       │
│        ▼                                         │
│   ┌──────────┐                                   │
│   │  Done?   │───── Yes ────► Exit               │
│   └──────────┘                                   │
└─────────────────────────────────────────────────┘
```

The magic is that while the **prompt stays the same**, Claude's **context changes** each iteration because:
- Files have been modified
- Git history shows previous work
- Test results reflect current state
- Build output shows progress

Claude reads its own previous work and continues from where it left off.

## How It Works Technically

Ralph Wiggum uses Claude Code's **Stop hook** mechanism:

1. You run `/ralph-loop "Build feature X" --completion-promise "DONE"`
2. Claude works on the task
3. Claude tries to exit (task complete or stuck)
4. The Stop hook intercepts the exit
5. Stop hook checks: did Claude output the completion promise?
   - **No**: Re-inject the same prompt, loop continues
   - **Yes**: Allow exit, task complete

## Key Concepts

### The Prompt Never Changes

This is counterintuitive but powerful. You don't update the prompt between iterations. Instead:

```
Iteration 1: Claude reads prompt, creates initial files
Iteration 2: Claude reads SAME prompt, sees files exist, continues
Iteration 3: Claude reads SAME prompt, sees test failures, fixes them
...
Iteration N: Claude reads SAME prompt, all criteria met, outputs "DONE"
```

### Completion Promise

A specific phrase that signals task completion:

```bash
/ralph-loop "Build a REST API. Output <promise>COMPLETE</promise> when done." \
  --completion-promise "COMPLETE"
```

Only exact string matches count. Claude must explicitly output this phrase.

### Self-Correction Pattern

Each iteration, Claude:
1. Reads existing files and git history
2. Runs tests/builds to see current state
3. Identifies gaps between current state and goal
4. Makes incremental progress
5. Either completes or gets another iteration

## When to Use Ralph Wiggum

### Good Use Cases

| Scenario | Why Ralph Works |
|----------|-----------------|
| **Greenfield features** | Clear end state, can iterate freely |
| **Test-driven development** | Tests provide automatic verification |
| **Refactoring with tests** | Tests catch regressions each iteration |
| **Documentation generation** | Can incrementally build and verify |
| **Migration scripts** | Can test and fix iteratively |

### Poor Use Cases

| Scenario | Why Ralph Doesn't Work |
|----------|------------------------|
| **Design decisions** | Needs human judgment, not iteration |
| **Production debugging** | Context is external to files |
| **One-shot operations** | No benefit from iteration |
| **Unclear requirements** | Will iterate forever without clear goal |

## Philosophy

### 1. Iteration Over Perfection

Don't try to write the perfect prompt. Let the loop refine the work.

### 2. Failures Are Data

A failed test run isn't a failure—it's information for the next iteration. "Deterministically bad" outcomes are predictable and useful.

### 3. Persistence Wins

The loop handles retry logic. You don't need to manually re-run after failures.

### 4. Operator Skill Matters

Success depends heavily on writing good prompts with clear completion criteria—not just model capability.

## Real-World Results

From the original author (ghuntley.com):
- Generated 6 repositories overnight during Y Combinator hackathon testing
- Completed a $50k contract for $297 in API costs
- Created an entire programming language over 3 months using this approach

## Comparison to Other Approaches

| Approach | Loop Location | Best For |
|----------|---------------|----------|
| **Ralph Wiggum** | Session-level (hooks) | Long autonomous work, greenfield projects |
| **Engineering Manager Agent** | Agent instructions | Bounded tasks, multi-specialist coordination |
| **Manual iteration** | You re-run commands | Quick fixes, exploration |

## Further Reading

- [Installing Ralph Wiggum](ralph-wiggum-installation.md)
- [Preparing and Running Ralph Loops](ralph-wiggum-usage.md)
- [Engineering Manager Agent Guide](engineering-manager-guide.md)
- [Original technique writeup](https://ghuntley.com/ralph/)
- [Official plugin](https://github.com/anthropics/claude-code/tree/main/plugins/ralph-wiggum)
