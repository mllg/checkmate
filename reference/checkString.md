# Check if an argument is a string

A string is defined as a scalar character vector. To check for vectors
of arbitrary length, see
[`checkCharacter`](https://mllg.github.io/checkmate/reference/checkCharacter.md).

## Usage

``` r
checkString(
  x,
  na.ok = FALSE,
  n.chars = NULL,
  min.chars = NULL,
  max.chars = NULL,
  pattern = NULL,
  fixed = NULL,
  ignore.case = FALSE,
  null.ok = FALSE
)

check_string(
  x,
  na.ok = FALSE,
  n.chars = NULL,
  min.chars = NULL,
  max.chars = NULL,
  pattern = NULL,
  fixed = NULL,
  ignore.case = FALSE,
  null.ok = FALSE
)

assertString(
  x,
  na.ok = FALSE,
  n.chars = NULL,
  min.chars = NULL,
  max.chars = NULL,
  pattern = NULL,
  fixed = NULL,
  ignore.case = FALSE,
  null.ok = FALSE,
  .var.name = vname(x),
  add = NULL
)

assert_string(
  x,
  na.ok = FALSE,
  n.chars = NULL,
  min.chars = NULL,
  max.chars = NULL,
  pattern = NULL,
  fixed = NULL,
  ignore.case = FALSE,
  null.ok = FALSE,
  .var.name = vname(x),
  add = NULL
)

testString(
  x,
  na.ok = FALSE,
  n.chars = NULL,
  min.chars = NULL,
  max.chars = NULL,
  pattern = NULL,
  fixed = NULL,
  ignore.case = FALSE,
  null.ok = FALSE
)

test_string(
  x,
  na.ok = FALSE,
  n.chars = NULL,
  min.chars = NULL,
  max.chars = NULL,
  pattern = NULL,
  fixed = NULL,
  ignore.case = FALSE,
  null.ok = FALSE
)

expect_string(
  x,
  na.ok = FALSE,
  n.chars = NULL,
  min.chars = NULL,
  max.chars = NULL,
  pattern = NULL,
  fixed = NULL,
  ignore.case = FALSE,
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

- n.chars:

  \[`integer(1)`\]  
  Exact number of characters for each element of `x`.

- min.chars:

  \[`integer(1)`\]  
  Minimum number of characters for each element of `x`.

- max.chars:

  \[`integer(1)`\]  
  Maximum number of characters for each element of `x`.

- pattern:

  \[`character(1)`\]  
  Regular expression as used in
  [`grepl`](https://rdrr.io/r/base/grep.html). All non-missing elements
  of `x` must comply to this pattern.

- fixed:

  \[`character(1)`\]  
  Substring to detect in `x`. Will be used as `pattern` in
  [`grepl`](https://rdrr.io/r/base/grep.html) with option `fixed` set to
  `TRUE`. All non-missing elements of `x` must contain this substring.

- ignore.case:

  \[`logical(1)`\]  
  See [`grepl`](https://rdrr.io/r/base/grep.html). Default is `FALSE`.

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
functions `assertString`/`assert_string` return `x` invisibly, whereas
`checkString`/`check_string` and `testString`/`test_string` return
`TRUE`. If the check is not successful, `assertString`/`assert_string`
throws an error message, `testString`/`test_string` returns `FALSE`, and
`checkString`/`check_string` return a string with the error message. The
function `expect_string` always returns an
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
[`checkScalar()`](https://mllg.github.io/checkmate/reference/checkScalar.md),
[`checkScalarNA()`](https://mllg.github.io/checkmate/reference/checkScalarNA.md)

## Examples

``` r
testString("a")
#> [1] TRUE
testString(letters)
#> [1] FALSE
```
