---
name: conventional-commits
description: Use this skill whenever the user asks to commit, create a commit message, stage and commit changes, or write a git commit. Also trigger when the user says "commit this", "make a commit", "commit my changes", "what should my commit message be", or anything involving git commit workflow. This skill ensures all commits follow the Conventional Commits specification.
version: 1.0.0
---

# Conventional Commits Skill

Guide every git commit to follow the [Conventional Commits](https://www.conventionalcommits.org/) specification.

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
- Co-author line when pair programming or using AI assistance

---

## Git Safety Protocol

- NEVER update git config
- NEVER run destructive commands (`--force`, `reset --hard`) without explicit user request
- NEVER skip hooks (`--no-verify`) unless user explicitly asks
- NEVER force push to `main`/`master`
- If a commit fails due to a pre-commit hook: fix the issue, re-stage, and create a **new** commit — never amend
