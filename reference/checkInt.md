# Check if an argument is a single integerish value

Check if an argument is a single integerish value

## Usage

``` r
checkInt(
  x,
  na.ok = FALSE,
  lower = -Inf,
  upper = Inf,
  tol = sqrt(.Machine$double.eps),
  null.ok = FALSE
)

check_int(
  x,
  na.ok = FALSE,
  lower = -Inf,
  upper = Inf,
  tol = sqrt(.Machine$double.eps),
  null.ok = FALSE
)

assertInt(
  x,
  na.ok = FALSE,
  lower = -Inf,
  upper = Inf,
  tol = sqrt(.Machine$double.eps),
  null.ok = FALSE,
  coerce = FALSE,
  .var.name = vname(x),
  add = NULL
)

assert_int(
  x,
  na.ok = FALSE,
  lower = -Inf,
  upper = Inf,
  tol = sqrt(.Machine$double.eps),
  null.ok = FALSE,
  coerce = FALSE,
  .var.name = vname(x),
  add = NULL
)

testInt(
  x,
  na.ok = FALSE,
  lower = -Inf,
  upper = Inf,
  tol = sqrt(.Machine$double.eps),
  null.ok = FALSE
)

test_int(
  x,
  na.ok = FALSE,
  lower = -Inf,
  upper = Inf,
  tol = sqrt(.Machine$double.eps),
  null.ok = FALSE
)

expect_int(
  x,
  na.ok = FALSE,
  lower = -Inf,
  upper = Inf,
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

- lower:

  \[`numeric(1)`\]  
  Lower value all elements of `x` must be greater than or equal to.

- upper:

  \[`numeric(1)`\]  
  Upper value all elements of `x` must be lower than or equal to.

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
functions `assertInt`/`assert_int` return `x` invisibly, whereas
`checkInt`/`check_int` and `testInt`/`test_int` return `TRUE`. If the
check is not successful, `assertInt`/`assert_int` throws an error
message, `testInt`/`test_int` returns `FALSE`, and
`checkInt`/`check_int` return a string with the error message. The
function `expect_int` always returns an
[`expectation`](https://testthat.r-lib.org/reference/expectation.html).

## Details

This function does not distinguish between `NA`, `NA_integer_`,
`NA_real_`, `NA_complex_` `NA_character_` and `NaN`.

## Note

To perform an assertion and then convert to integer, use
[`asInt`](https://mllg.github.io/checkmate/reference/asInteger.md).
`assertInt` will not convert numerics to integer.

## See also

Other scalars:
[`checkCount()`](https://mllg.github.io/checkmate/reference/checkCount.md),
[`checkFlag()`](https://mllg.github.io/checkmate/reference/checkFlag.md),
[`checkNumber()`](https://mllg.github.io/checkmate/reference/checkNumber.md),
[`checkScalar()`](https://mllg.github.io/checkmate/reference/checkScalar.md),
[`checkScalarNA()`](https://mllg.github.io/checkmate/reference/checkScalarNA.md),
[`checkString()`](https://mllg.github.io/checkmate/reference/checkString.md)

## Examples

``` r
testInt(1)
#> [1] TRUE
testInt(-1, lower = 0)
#> [1] FALSE
```
