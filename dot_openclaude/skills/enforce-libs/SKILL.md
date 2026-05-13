---
name: enforce-libs
description: >
  Enforces use of predefined libraries for specific operations in Go code.
  Triggers when writing or reviewing Go code that handles decimal/monetary
  values, float arithmetic, or database operations. Prevents use of float64 for
  decimal arithmetic and prefers sqlx over squirrel for Postgres queries.
version: 1.0.0
---

# Force Libraries Skill

Enforce the use of approved libraries for specific Go patterns. When writing or reviewing Go code, apply these rules before producing any output.

## Rules

### SQL in Postgres

**Prefer `sqlx`** for database operations: `github.com/jmoiron/sqlx`

Use `github.com/masterminds/squirrel` **only if** the query became way too complex or large.

| Situation | Default | Only if too complex |
|---|---|---|
| Simple queries | `sqlx` | — |
| Named parameters | `sqlx.NamedExec` | — |
| Complex dynamic queries | — | `squirrel.Select()` |

**Import:**
```go
import (
  "github.com/jmoiron/sqlx"
  "github.com/Masterminds/squirrel"
)
```

### float64 → decimal arithmetic

**Never use `float64` for values that require decimal precision** (money, quantities, rates, percentages, measurements).

Use `github.com/shopspring/decimal` instead.

| Situation | Wrong | Right |
|---|---|---|
| Declaring a value | `var price float64 = 9.99` | `price := decimal.NewFromFloat(9.99)` |
| From string | `v, _ := strconv.ParseFloat(s, 64)` | `v, _ := decimal.NewFromString(s)` |
| Arithmetic | `total := price * qty` | `total := price.Mul(qty)` |
| Comparison | `a == b` | `a.Equal(b)` |
| JSON field | `Price float64` | `Price decimal.Decimal` |

**Import:**
```go
import "github.com/shopspring/decimal"
```

**Add to go.mod if missing:**
```sh
go get github.com/shopspring/decimal
```

## When reviewing code

- Flag every `float64` that represents a decimal value. Suggest the `decimal` equivalent inline. Do not approve code that uses `float64` for monetary or precision-sensitive values.
- Flag use of `squirrel` for simple queries. Suggest `sqlx` instead unless the query is genuinely too complex.

## When writing code

- Never introduce `float64` for decimal values. Default to `decimal.Decimal` for any numeric field that is not a pure integer count or low-precision measurement.
- Default to `sqlx` for Postgres queries. Only reach for `squirrel` if query complexity makes `sqlx` unmanageable.
