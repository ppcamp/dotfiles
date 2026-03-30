Review all staged and unstaged changes in the current branch against the base branch using the senior-code-reviewer agent.

Steps:
1. Run `git diff HEAD` to capture all uncommitted changes and `git diff develop...HEAD` to capture all commits ahead of develop.
2. Run `git status` to identify any untracked files.
3. Pass the full diff and context to the senior-code-reviewer agent with the following prompt:

"Review the following git diff for this Go microservice (accounting engine). Focus on:
- Correctness: logic errors, off-by-ones, nil dereferences, goroutine leaks
- Security: SQL injection, untrusted input, secrets in code
- Concurrency: race conditions, improper mutex use, channel misuse
- Error handling: swallowed errors, missing returns, improper wrapping
- Testing: are the tests meaningful? do they cover edge cases?
- Go idioms: proper use of interfaces, context propagation, defer
- Linting compliance: cyclomatic complexity ≤ 30, function length ≤ 100 lines

Provide a structured report with: CRITICAL, WARNING, and SUGGESTION sections. Be concise."
