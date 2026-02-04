# Check if an argument is a flag

A flag is defined as single logical value.

## Usage

``` r
checkFlag(x, na.ok = FALSE, null.ok = FALSE)

check_flag(x, na.ok = FALSE, null.ok = FALSE)

assertFlag(x, na.ok = FALSE, null.ok = FALSE, .var.name = vname(x), add = NULL)

assert_flag(
  x,
  na.ok = FALSE,
  null.ok = FALSE,
  .var.name = vname(x),
  add = NULL
)

testFlag(x, na.ok = FALSE, null.ok = FALSE)

test_flag(x, na.ok = FALSE, null.ok = FALSE)

expect_flag(x, na.ok = FALSE, null.ok = FALSE, info = NULL, label = vname(x))
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
functions `assertFlag`/`assert_flag` return `x` invisibly, whereas
`checkFlag`/`check_flag` and `testFlag`/`test_flag` return `TRUE`. If
the check is not successful, `assertFlag`/`assert_flag` throws an error
message, `testFlag`/`test_flag` returns `FALSE`, and
`checkFlag`/`check_flag` return a string with the error message. The
function `expect_flag` always returns an
[`expectation`](https://testthat.r-lib.org/reference/expectation.html).

## Details

This function does not distinguish between `NA`, `NA_integer_`,
`NA_real_`, `NA_complex_` `NA_character_` and `NaN`.

## See also

Other scalars:
[`checkCount()`](https://mllg.github.io/checkmate/reference/checkCount.md),
[`checkInt()`](https://mllg.github.io/checkmate/reference/checkInt.md),
[`checkNumber()`](https://mllg.github.io/checkmate/reference/checkNumber.md),
[`checkScalar()`](https://mllg.github.io/checkmate/reference/checkScalar.md),
[`checkScalarNA()`](https://mllg.github.io/checkmate/reference/checkScalarNA.md),
[`checkString()`](https://mllg.github.io/checkmate/reference/checkString.md)

## Examples

``` r
testFlag(TRUE)
#> [1] TRUE
testFlag(1)
#> [1] FALSE
```
