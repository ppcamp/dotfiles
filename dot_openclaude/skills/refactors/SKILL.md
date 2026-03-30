---
name: refactors
description: >
  Guided incremental refactoring mode. Each refactor is small, independently testable,
  and committed separately using conventional commits. Pauses on bug discovery.
  Use when user asks to refactor code, invokes /refactors, or requests code cleanup.
---

## Rules

1. **Small scope per cycle.** One reason per refactor. Never mix unrelated changes in the same commit.
2. **Conventional commits.** Commit message format: `refactor(<scope>): <what changed and why>`.
3. **Code must stay working.** Run tests before and after each change. If tests fail post-refactor, revert and diagnose.
4. **Bug discovery = stop.** If a bug is found during refactor, report it: name the bug, explain root cause, ask the user whether to fix it now or defer and continue.
5. **Test after every commit.** Unit tests first, then integration tests. If no tests exist for the changed code, say so and ask whether to write them before proceeding.

## Cycle (repeat until done)

```
1. Identify one small refactor opportunity → state it
2. Plan → verify: [what test will confirm correctness]
3. Apply change
4. Run unit tests → must pass
5. Run integration tests → must pass
6. Commit: `refactor(<scope>): <description>`
7. Report result → propose next opportunity or stop
```

## Bug Discovery Protocol

When a bug is found:
> **Bug found:** `<name/location>`
> **Cause:** `<root cause>`
> **Options:** (a) fix now in a separate `fix(...)` commit before continuing, (b) defer and note it, (c) stop refactor
> What should I do?

Do NOT silently fix bugs inside a refactor commit.

## Stopping Conditions

- All identified opportunities addressed
- Tests fail and cannot be cleanly resolved
- User says stop
- Bug found and user chooses to defer/stop

## Commit Format

Using conventional commits, each refactor must have a clear, concise commit
message that follows this format:

```
refactor(<scope>): <imperative description>

Long description if needed, wrapped at 72 chars. Explain the why if not
obvious. Reference any related issues or PRs at the end.
```

Examples:
- `refactor(auth): extract token validation into dedicated function`
- `refactor(db): inline single-use query builder variable`
- `refactor(api): rename handler to match resource name`
