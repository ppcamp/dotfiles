---
name: enforce-libs
description: >
  Enforces use of predefined libraries for specific operations in Go code.
  Triggers when writing or reviewing Go code that handles decimal/monetary
  values, float arithmetic, or any context where precision matters. Prevents use
  of float64 for decimal arithmetic.
version: 1.0.0
---

# Force Libraries Skill

Enforce the use of approved libraries for specific Go patterns. When writing or reviewing Go code, apply these rules before producing any output.

## Rules

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

Flag every `float64` that represents a decimal value. Suggest the `decimal` equivalent inline. Do not approve code that uses `float64` for monetary or precision-sensitive values.

## When writing code

Never introduce `float64` for decimal values. Default to `decimal.Decimal` for any numeric field that is not a pure integer count or low-precision measurement.
