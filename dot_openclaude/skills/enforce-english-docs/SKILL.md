---
name: enforce-english-docs
description: >
  Enforces English-only documentation across all written artifacts.
  Triggers when writing or reviewing comments, docstrings, README files,
  changelogs, commit messages, API docs, or any other human-readable text.
  Rewrites non-English documentation into English before producing output.
version: 1.0.0
---

# Enforce English Documentation

All documentation must be written in English. Apply this rule before producing any output that contains human-readable text.

## Scope

This rule covers every artifact intended to be read by humans:

- Code comments (inline, block, section headers)
- Docstrings and JSDoc / godoc / rustdoc blocks
- README, CHANGELOG, CONTRIBUTING, and other Markdown files
- Commit messages and PR descriptions
- API documentation strings
- Error messages exposed to developers (not end-users)
- Variable names, function names, and identifiers when they embed natural language

## Rules

### When writing

Always produce documentation in English regardless of the language the user wrote their prompt in. If the user writes a prompt in Portuguese, French, Spanish, or any other language, the *code and documentation output* must still be in English. You may respond conversationally in the user's language, but all written artifacts must be in English.

### When reviewing

Flag every non-English string found in documentation scope. For each finding:

1. Quote the original non-English text.
2. Provide the English translation/rewrite.
3. Note the file and location.

Do not approve or merge documentation that contains non-English text.

### When translating existing docs

Translate fully — do not leave mixed-language blocks. Preserve meaning, technical accuracy, and formatting. Do not paraphrase; translate as closely as possible.

## Examples

| Wrong | Right |
|-------|-------|
| `// Retorna o usuário pelo ID` | `// Returns the user by ID` |
| `# Configuração` (README heading) | `# Configuration` |
| `/** Calcula o total com desconto */` | `/** Calculates the total with discount applied */` |
| `feat: adiciona autenticação JWT` | `feat: add JWT authentication` |
| `error: arquivo não encontrado` | `error: file not found` |

## Exceptions

- String literals that are user-facing UI copy (translations are intentional there).
- Test fixtures containing foreign-language strings specifically to test i18n/l10n behavior.
- Third-party files that are not owned by this project.

In all exception cases, leave the foreign-language text untouched and note why it was skipped.
