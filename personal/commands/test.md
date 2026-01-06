# Test Command

Generate or run tests for the codebase.

## Usage
```
/test                    # Run all tests
/test <file>             # Generate tests for specific file
/test --coverage         # Run with coverage report
/test --generate <path>  # Generate tests for path
```

## Instructions

### Running Tests
1. Execute `npm test` or `npm run test:run`
2. Report results with pass/fail counts
3. Highlight any failures with details

### Generating Tests
1. Read the source file to understand functionality
2. Identify testable units (functions, components, procedures)
3. Generate comprehensive tests covering:
   - Happy path scenarios
   - Edge cases
   - Error conditions
4. Follow project test patterns

## Test Patterns

### tRPC Procedure
```typescript
import { describe, it, expect } from 'vitest';
import { appRouter } from '~/server/api/root';
import { createInnerTRPCContext } from '~/server/api/trpc';

describe('procedureName', () => {
  it('should handle valid input', async () => {
    const ctx = createInnerTRPCContext({ session: mockSession });
    const caller = appRouter.createCaller(ctx);
    const result = await caller.namespace.procedure({ input: 'value' });
    expect(result).toBeDefined();
  });
});
```

### React Component
```typescript
import { describe, it, expect } from 'vitest';
import { render, screen } from '~/test/utils';
import { Component } from './Component';

describe('Component', () => {
  it('renders correctly', () => {
    render(<Component />);
    expect(screen.getByRole('button')).toBeInTheDocument();
  });
});
```

## Output Format

### When Running Tests
```
## Test Results

**Status**: PASS / FAIL
**Tests**: X passed, Y failed, Z skipped
**Time**: X.XXs

### Failures (if any)
- test name: error message

### Coverage (if requested)
- Lines: XX%
- Branches: XX%
- Functions: XX%
```

### When Generating Tests
```
## Generated Tests

**File**: path/to/file.test.ts
**Coverage**: What the tests cover

\`\`\`typescript
// Test code here
\`\`\`

### Next Steps
- Run `npm test` to verify
- Add to version control
```
