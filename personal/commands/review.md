# Code Review Command

Perform a comprehensive code review of the current changes or specified files.

## Usage
```
/review              # Review all staged/changed files
/review <file>       # Review specific file
/review --pr         # Review for PR readiness
```

## Instructions

1. **Identify Changes**: Check `git status` and `git diff` for modified files
2. **Review Each File**: Analyze against the code review checklist
3. **Report Findings**: Categorize by severity (Blocker/Major/Minor/Suggestion)
4. **Provide Fixes**: Include specific recommendations for each issue

## Review Checklist

### Type Safety
- [ ] No `any` types without justification
- [ ] Proper Zod schemas for inputs
- [ ] Correct TypeScript inference

### tRPC Patterns
- [ ] Correct procedure type (public/protected)
- [ ] Input validation present
- [ ] Error handling appropriate

### Code Quality
- [ ] DRY principle followed
- [ ] Single responsibility
- [ ] Naming conventions correct

### Security
- [ ] Input sanitization
- [ ] Auth checks where needed
- [ ] No hardcoded secrets

## Output Format

Provide findings as:

```
## Code Review Results

### Summary
X files reviewed, Y issues found

### Critical Issues (Must Fix)
- [BLOCKER] file:line - Issue description
  - Fix: Specific recommendation

### Major Issues (Should Fix)
- [MAJOR] file:line - Issue description

### Minor Issues
- [MINOR] file:line - Issue description

### Suggestions
- [SUGGESTION] Optional improvements

### Verdict
APPROVED / CHANGES REQUESTED / NEEDS DISCUSSION
```
