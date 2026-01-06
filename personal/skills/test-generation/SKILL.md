---
name: test-generation
description: Generate comprehensive tests for TypeScript/React code. Use when creating unit tests, integration tests, E2E tests, or when the user mentions testing, test coverage, Vitest, Jest, or Playwright. Specializes in Next.js 15, tRPC, and Prisma testing patterns.
allowed-tools: Read, Grep, Glob, Write, Bash
---

# Test Generation Skill

Generate tests for TypeScript/React applications using Vitest and React Testing Library.

## Quick Reference

### Test Framework
- **Runner**: Vitest
- **Component Testing**: React Testing Library
- **Setup**: `src/test/setup.ts`
- **Utilities**: `src/test/utils.tsx`

### Commands
```bash
npm test              # Watch mode
npm run test:run      # Single run
npm run test:coverage # With coverage
```

## Test Patterns

### tRPC Procedure Test
```typescript
import { describe, it, expect, vi } from 'vitest';
import { appRouter } from '~/server/api/root';
import { createInnerTRPCContext } from '~/server/api/trpc';

describe('router.procedure', () => {
  it('should work for authenticated users', async () => {
    const ctx = createInnerTRPCContext({
      session: {
        user: { id: 'user-1', name: 'Test', email: 'test@test.com' },
        expires: new Date(Date.now() + 86400000).toISOString(),
      },
    });
    const caller = appRouter.createCaller(ctx);

    const result = await caller.namespace.procedure({ input: 'value' });

    expect(result).toBeDefined();
  });
});
```

### React Component Test
```typescript
import { describe, it, expect } from 'vitest';
import { render, screen } from '~/test/utils';
import { MyComponent } from './MyComponent';

describe('MyComponent', () => {
  it('renders correctly', () => {
    render(<MyComponent prop="value" />);
    expect(screen.getByText('expected text')).toBeInTheDocument();
  });
});
```

### Utility Function Test
```typescript
import { describe, it, expect } from 'vitest';
import { myFunction } from './utils';

describe('myFunction', () => {
  it('handles normal input', () => {
    expect(myFunction('input')).toBe('expected');
  });

  it('handles edge cases', () => {
    expect(myFunction('')).toBe('default');
  });
});
```

## Coverage Requirements

- **Target**: 80% for new code
- **Focus**: Business logic, tRPC procedures, utility functions
- **Priority**: Mutations > Queries > UI components

## File Naming

- Unit tests: `*.test.ts` / `*.test.tsx`
- Co-locate with source or use `__tests__/` directory
