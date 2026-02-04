# Check if an argument is a single atomic value

Check if an argument is a single atomic value

## Usage

``` r
checkScalar(x, na.ok = FALSE, null.ok = FALSE)

check_scalar(x, na.ok = FALSE, null.ok = FALSE)

assertScalar(
  x,
  na.ok = FALSE,
  null.ok = FALSE,
  .var.name = vname(x),
  add = NULL
)

assert_scalar(
  x,
  na.ok = FALSE,
  null.ok = FALSE,
  .var.name = vname(x),
  add = NULL
)

testScalar(x, na.ok = FALSE, null.ok = FALSE)

test_scalar(x, na.ok = FALSE, null.ok = FALSE)

expect_scalar(x, na.ok = FALSE, null.ok = FALSE, info = NULL, label = vname(x))
```

## Arguments

- x:

  \[`any`\]  
  Object to check.

- na.ok:

  \[`logical(1)`\]  
  Are missing values allowed? Default is `FALSE`.

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
functions `assertScalar`/`assert_scalar` return `x` invisibly, whereas
`checkScalar`/`check_scalar` and `testScalar`/`test_scalar` return
`TRUE`. If the check is not successful, `assertScalar`/`assert_scalar`
throws an error message, `testScalar`/`test_scalar` returns `FALSE`, and
`checkScalar`/`check_scalar` return a string with the error message. The
function `expect_scalar` always returns an
[`expectation`](https://testthat.r-lib.org/reference/expectation.html).

## Details

This function does not distinguish between `NA`, `NA_integer_`,
`NA_real_`, `NA_complex_` `NA_character_` and `NaN`.

## See also

Other scalars:
[`checkCount()`](https://mllg.github.io/checkmate/reference/checkCount.md),
[`checkFlag()`](https://mllg.github.io/checkmate/reference/checkFlag.md),
[`checkInt()`](https://mllg.github.io/checkmate/reference/checkInt.md),
[`checkNumber()`](https://mllg.github.io/checkmate/reference/checkNumber.md),
[`checkScalarNA()`](https://mllg.github.io/checkmate/reference/checkScalarNA.md),
[`checkString()`](https://mllg.github.io/checkmate/reference/checkString.md)

## Examples

``` r
testScalar(1)
#> [1] TRUE
testScalar(1:10)
#> [1] FALSE
```
