# Integer Math Conformance Test Analysis

## Summary
Out of 64 integer math conformance tests, 20 are failing (68.8% success rate). The failures fall into several categories:

## Issue Categories

### 1. Modulo Operation Behavior (2 failures)
**Tests**: `mod_negative_negative`, `mod_negative_positive`

**Problem**: Dart's modulo operator `%` behaves differently from Go/CEL specification.

- **Dart behavior**: 
  - `-42 % -5 = 3`
  - `-3 % 5 = 2`

- **Expected CEL/Go behavior**:
  - `-42 % -5 = -2` 
  - `-3 % 5 = -3`

**Root Cause**: In `/Users/titanous/Developer/protovalidate-dart/cel-dart/lib/src/common/types/int.dart` line 60, the modulo operation uses Dart's native `%` operator which follows different rules than Go's modulo.

### 2. Unary Minus Parser Issue (6 failures)
**Tests**: `unary_minus_pos`, `unary_minus_neg`, `unary_minus_no_overload`, `unary_minus_not_bool`, `negative_zero`, `double_negative`

**Problem**: The parser's `visitUnary` method in `/Users/titanous/Developer/protovalidate-dart/cel-dart/lib/src/parser/parser.dart` line 486 just returns `StringLiteralExpr('<<error>>')` instead of properly parsing unary expressions.

**Impact**: All unary minus operations (like `-(42)`) return the literal string `"<<error>>"` instead of the negated value.

### 3. Overflow Detection Missing (12 failures)
**Tests**: All `*_overflow_*` tests

**Problem**: The CEL specification requires arithmetic operations to detect overflow and return errors, but the current implementation performs operations using Dart's native arithmetic which wraps around on overflow.

**Examples**:
- `9223372036854775807 + 1` should return an overflow error but returns `-9223372036854775808` (wrapped)
- `18446744073709551615u + 1u` should return an overflow error but returns `0` (wrapped)
- `5000000000 * 5000000000` should return an overflow error but returns an incorrect wrapped value

**Root Cause**: The arithmetic operations in `/Users/titanous/Developer/protovalidate-dart/cel-dart/lib/src/common/types/int.dart` and `/Users/titanous/Developer/protovalidate-dart/cel-dart/lib/src/common/types/uint.dart` don't check for overflow before performing operations.

## Detailed Failure Analysis

### Modulo Failures
1. `mod_negative_negative`: `-42 % (-5)` returns `3` but should return `-2`
2. `mod_negative_positive`: `-3 % 5` returns `2` but should return `-3`

### Unary Minus Failures
3. `unary_minus_pos`: `-(42)` returns `"<<error>>"` but should return `-42`
4. `unary_minus_neg`: `-(-42)` returns `"<<error>>"` but should return `42`
5. `negative_zero`: `-(0)` returns `"<<error>>"` but should return `0`
6. `double_negative`: `-(-42)` returns `"<<error>>"` but should return `42`
7. `unary_minus_no_overload`: `-(42u)` should return an error but currently returns `"<<error>>"` which isn't properly detected as an error
8. `unary_minus_not_bool`: `-false` should return an error but currently returns `"<<error>>"` which isn't properly detected as an error

### Overflow Detection Failures
9. `int64_overflow_positive`: `9223372036854775807 + 1` returns `-9223372036854775808` but should return overflow error
10. `int64_overflow_negative`: `-9223372036854775808 - 1` returns `9223372036854775807` but should return overflow error
11. `int64_overflow_add_negative`: `-9223372036854775808 + (-1)` returns `9223372036854775807` but should return overflow error
12. `int64_overflow_sub_positive`: `1 - (-9223372036854775807)` returns `-9223372036854775808` but should return overflow error
13. `int64_min_negate`: `-(-9223372036854775808)` should return overflow error (this one might work since the negate method has the check)
14. `int64_min_negate_mul`: `(-9223372036854775808) * -1` returns `-9223372036854775808` but should return overflow error
15. `int64_overflow_mul_positive`: `5000000000 * 5000000000` returns `6553255926290448384` but should return overflow error
16. `int64_overflow_mul_negative`: `(-5000000000) * 5000000000` returns `-6553255926290448384` but should return overflow error
17. `uint64_overflow_positive`: `18446744073709551615u + 1u` returns `0` but should return overflow error
18. `uint64_overflow_negative`: `0u - 1u` returns `-1` but should return overflow error (note: this suggests uint operations are being converted to signed)
19. `uint64_overflow_mul_positive`: `5000000000u * 5000000000u` returns `6553255926290448384` but should return overflow error
20. `negative_no_overload`: `-(5u)` should return an error but currently returns `"<<error>>"` which isn't properly detected as an error

## Implementation Requirements

### Priority 1: Fix Unary Minus Parser
The most critical issue is the unary parser returning literal error strings. This needs to be implemented to properly parse and evaluate unary expressions.

### Priority 2: Implement Go-Style Modulo
The modulo operation needs to be reimplemented to match Go/CEL semantics where the result has the same sign as the dividend.

### Priority 3: Add Overflow Detection
All arithmetic operations (add, subtract, multiply, divide) need to check for overflow before performing the operation and return appropriate error values.

## Files That Need Changes

1. `/Users/titanous/Developer/protovalidate-dart/cel-dart/lib/src/parser/parser.dart` - Fix `visitUnary` method
2. `/Users/titanous/Developer/protovalidate-dart/cel-dart/lib/src/common/types/int.dart` - Fix modulo behavior and add overflow checks
3. `/Users/titanous/Developer/protovalidate-dart/cel-dart/lib/src/common/types/uint.dart` - Add overflow checks and fix uint behavior