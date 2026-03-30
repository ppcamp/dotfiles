---
name: conventional-commits
description: >
  Use this skill whenever the user asks to commit, create a commit message,
  stage and commit changes, or write a git commit. Also trigger when the user
  says "commit this", "make a commit", "commit my changes", "what should my
  commit message be", or anything involving git commit workflow. This skill
  ensures all commits follow the Conventional Commits specification.
version: 1.0.0
---

# Conventional Commits Skill

Guide every git commit to follow the [Conventional Commits](https://www.conventionalcommits.org/) specification.

**ALL COMMITS MUST BE IN ENGLISH.**

## Commit Format

```
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]
```

## Commit Types

| Type       | Purpose                             |
|------------|-------------------------------------|
| `feat`     | New feature                         |
| `fix`      | Bug fix                             |
| `docs`     | Documentation only                  |
| `style`    | Formatting/style (no logic change)  |
| `refactor` | Refactor (no feature/fix)           |
| `perf`     | Performance improvement             |
| `test`     | Add/update tests                    |
| `build`    | Build system or dependencies        |
| `ci`       | CI/CD config changes                |
| `chore`    | Maintenance/misc                    |
| `revert`   | Revert a previous commit            |

## Breaking Changes

Use a `BREAKING CHANGE:` footer:

```
BREAKING CHANGE: Node 12 is no longer supported
```

---

## Workflow

### Step 1 — Analyze what's changed

Check staged changes first; fall back to working tree if nothing is staged:

```sh
git diff --staged
git diff
git status --porcelain
```

### Step 2 — Stage files if needed

Group related changes together — one logical unit per commit:

```sh
git add path/to/file1 path/to/file2   # specific files
git add src/components/*               # by pattern
```

Never stage secrets (`.env`, credentials, private keys).

### Step 3 — Choose type, scope, and description

- **Type**: what kind of change? (see table above)
- **Scope**: what area/module? (e.g., `auth`, `api`, `ui`) — keep it short and lowercase
- **Description**: imperative mood, present tense, under 72 chars ("add" not "added", "fix" not "fixes")

### Step 4 — Execute the commit

```sh
# Single-line
git commit -m "<type>[scope]: <description>"

# Multi-line with body/footer
git commit -m "$(cat <<'EOF'
<type>[scope]: <description>

<optional body explaining WHY, not what>

<optional footer: Closes #123, BREAKING CHANGE: ...>
EOF
)"
```

---

## Examples

**Simple feature:**
```
feat(auth): add OAuth2 login via Google
```

**Bug fix referencing an issue:**
```
fix(api): handle null response from payment gateway

Closes #412
```

**Breaking change:**
```
feat(config)!: rename `timeout` to `request_timeout`

BREAKING CHANGE: the `timeout` field in config files must be renamed to `request_timeout`
```

**Chore with scope:**
```
chore(deps): upgrade Go to 1.22
```

---

## Best Practices

- One logical change per commit — split unrelated changes into separate commits
- Body explains **why**, not what (the diff shows what)
- Reference issues in footer: `Closes #123`, `Refs #456`
- Keep description under 72 characters
- Commit messages must be in English for consistency and clarity across teams.
- Commit messages should be clear and concise, avoiding unnecessary jargon or
  abbreviations that may not be universally understood.
- Commit messages should be written in the imperative mood, as if giving a
  command (e.g., "add", "fix", "update") rather than describing past actions
  (e.g., "added", "fixed", "updated").
- Commit messages should avoid personal pronouns ("I", "we") and temporal words
  ("now", "currently") since the commit history itself provides context on who
  made the change and when.
- Commit message, first line, should not end with a period.
- Co-author line when pair programming or using AI assistance
- Emoji (unless project convention requires)
- **Body (only if needed):**
  - Skip entirely when subject is self-explanatory
  - Add body only for: non-obvious *why*, breaking changes, migration notes,
    linked issues
  - Bullets `-` not `*`
  - Reference issues/tasks/PRs at end: `Closes #42`, `Refs #17`, `Task #123`

## Examples

    Diff: new endpoint for user profile with body explaining the why
    - ❌ "feat: add a new endpoint to get user profile information from the database"
    - ✅
    ```
    feat(api): add GET /users/:id/profile

               Mobile client needs profile data without the full user payload
               to reduce LTE bandwidth on cold-launch screens.

               Closes #128
               ```

               Diff: breaking API change
               - ✅
               ```
               feat(api)!: rename /v1/orders to /v1/checkout

               BREAKING CHANGE: clients on /v1/orders must migrate to /v1/checkout
               before 2026-06-01. Old route returns 410 after that date.
               ```


---

## Git Safety Protocol

- NEVER update git config
- NEVER run destructive commands (`--force`, `reset --hard`) without explicit user request
- NEVER skip hooks (`--no-verify`) unless user explicitly asks
- NEVER force push to `main`/`master`
- If a commit fails due to a pre-commit hook: fix the issue, re-stage, and create a **new** commit — never amend
