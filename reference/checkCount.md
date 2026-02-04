# Check if an argument is a count

A count is defined as non-negative integerish value.

## Usage

``` r
checkCount(
  x,
  na.ok = FALSE,
  positive = FALSE,
  tol = sqrt(.Machine$double.eps),
  null.ok = FALSE
)

check_count(
  x,
  na.ok = FALSE,
  positive = FALSE,
  tol = sqrt(.Machine$double.eps),
  null.ok = FALSE
)

assertCount(
  x,
  na.ok = FALSE,
  positive = FALSE,
  tol = sqrt(.Machine$double.eps),
  null.ok = FALSE,
  coerce = FALSE,
  .var.name = vname(x),
  add = NULL
)

assert_count(
  x,
  na.ok = FALSE,
  positive = FALSE,
  tol = sqrt(.Machine$double.eps),
  null.ok = FALSE,
  coerce = FALSE,
  .var.name = vname(x),
  add = NULL
)

testCount(
  x,
  na.ok = FALSE,
  positive = FALSE,
  tol = sqrt(.Machine$double.eps),
  null.ok = FALSE
)

test_count(
  x,
  na.ok = FALSE,
  positive = FALSE,
  tol = sqrt(.Machine$double.eps),
  null.ok = FALSE
)

expect_count(
  x,
  na.ok = FALSE,
  positive = FALSE,
  tol = sqrt(.Machine$double.eps),
  null.ok = FALSE,
  info = NULL,
  label = vname(x)
)
```

## Arguments

- x:

  \[`any`\]  
  Object to check.

- na.ok:

  \[`logical(1)`\]  
  Are missing values allowed? Default is `FALSE`.

- positive:

  \[`logical(1)`\]  
  Must `x` be positive (\>= 1)? Default is `FALSE`, allowing 0.

- tol:

  \[`double(1)`\]  
  Numerical tolerance used to check whether a double or complex can be
  converted. Default is `sqrt(.Machine$double.eps)`.

- null.ok:

  \[`logical(1)`\]  
  If set to `TRUE`, `x` may also be `NULL`. In this case only a type
  check of `x` is performed, all additional checks are disabled.

- coerce:

  \[`logical(1)`\]  
  If `TRUE`, the input `x` is returned as integer after an successful
  assertion.

- .var.name:

  \[`character(1)`\]  
  Name of the checked object to print in assertions. Defaults to the
  heuristic implemented in
  [`vname`](https://mllg.github.io/checkmate/reference/vname.md).

- add:

  \[`AssertCollection`\]  
  Collection to store assertion messages. See
  [`AssertCollection`](https://mllg.github.io/checkmate/reference/AssertCollection.md).

- info:

  \[`character(1)`\]  
  Extra information to be included in the message for the testthat
  reporter. See
  [`expect_that`](https://testthat.r-lib.org/reference/expect_that.html).

- label:

  \[`character(1)`\]  
  Name of the checked object to print in messages. Defaults to the
  heuristic implemented in
  [`vname`](https://mllg.github.io/checkmate/reference/vname.md).

## Value

Depending on the function prefix: If the check is successful, the
functions `assertCount`/`assert_count` return `x` invisibly, whereas
`checkCount`/`check_count` and `testCount`/`test_count` return `TRUE`.
If the check is not successful, `assertCount`/`assert_count` throws an
error message, `testCount`/`test_count` returns `FALSE`, and
`checkCount`/`check_count` return a string with the error message. The
function `expect_count` always returns an
[`expectation`](https://testthat.r-lib.org/reference/expectation.html).

## Details

This function does not distinguish between `NA`, `NA_integer_`,
`NA_real_`, `NA_complex_` `NA_character_` and `NaN`.

## Note

To perform an assertion and then convert to integer, use
[`asCount`](https://mllg.github.io/checkmate/reference/asInteger.md).
`assertCount` will not convert numerics to integer.

## See also

Other scalars:
[`checkFlag()`](https://mllg.github.io/checkmate/reference/checkFlag.md),
[`checkInt()`](https://mllg.github.io/checkmate/reference/checkInt.md),
[`checkNumber()`](https://mllg.github.io/checkmate/reference/checkNumber.md),
[`checkScalar()`](https://mllg.github.io/checkmate/reference/checkScalar.md),
[`checkScalarNA()`](https://mllg.github.io/checkmate/reference/checkScalarNA.md),
[`checkString()`](https://mllg.github.io/checkmate/reference/checkString.md)

## Examples

``` r
testCount(1)
#> [1] TRUE
testCount(-1)
#> [1] FALSE
```
