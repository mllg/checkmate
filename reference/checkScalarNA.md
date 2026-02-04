# Check if an argument is a single missing value

Check if an argument is a single missing value

## Usage

``` r
checkScalarNA(x, null.ok = FALSE)

check_scalar_na(x, null.ok = FALSE)

assertScalarNA(x, null.ok = FALSE, .var.name = vname(x), add = NULL)

assert_scalar_na(x, null.ok = FALSE, .var.name = vname(x), add = NULL)

testScalarNA(x, null.ok = FALSE)

test_scalar_na(x, null.ok = FALSE)

expect_scalar_na(x, null.ok = FALSE, info = NULL, label = vname(x))
```

## Arguments

- x:

  \[`any`\]  
  Object to check.

- null.ok:

  \[`logical(1)`\]  
  If set to `TRUE`, `x` may also be `NULL`. In this case only a type
  check of `x` is performed, all additional checks are disabled.

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
functions `assertScalarNA`/`assert_scalar_na` return `x` invisibly,
whereas `checkScalarNA`/`check_scalar_na` and
`testScalarNA`/`test_scalar_na` return `TRUE`. If the check is not
successful, `assertScalarNA`/`assert_scalar_na` throws an error message,
`testScalarNA`/`test_scalar_na` returns `FALSE`, and
`checkScalarNA`/`check_scalar_na` return a string with the error
message. The function `expect_scalar_na` always returns an
[`expectation`](https://testthat.r-lib.org/reference/expectation.html).

## See also

Other scalars:
[`checkCount()`](https://mllg.github.io/checkmate/reference/checkCount.md),
[`checkFlag()`](https://mllg.github.io/checkmate/reference/checkFlag.md),
[`checkInt()`](https://mllg.github.io/checkmate/reference/checkInt.md),
[`checkNumber()`](https://mllg.github.io/checkmate/reference/checkNumber.md),
[`checkScalar()`](https://mllg.github.io/checkmate/reference/checkScalar.md),
[`checkString()`](https://mllg.github.io/checkmate/reference/checkString.md)

## Examples

``` r
testScalarNA(1)
#> [1] FALSE
testScalarNA(NA_real_)
#> [1] TRUE
testScalarNA(rep(NA, 2))
#> [1] FALSE
```
