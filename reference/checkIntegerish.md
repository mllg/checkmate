# Check if an object is an integerish vector

An integerish value is defined as value safely convertible to integer.
This includes integers and numeric values which sufficiently close to an
integer w.r.t. a numeric tolerance \`tol\`.

## Usage

``` r
checkIntegerish(
  x,
  tol = sqrt(.Machine$double.eps),
  lower = -Inf,
  upper = Inf,
  any.missing = TRUE,
  all.missing = TRUE,
  len = NULL,
  min.len = NULL,
  max.len = NULL,
  unique = FALSE,
  sorted = FALSE,
  names = NULL,
  typed.missing = FALSE,
  null.ok = FALSE
)

check_integerish(
  x,
  tol = sqrt(.Machine$double.eps),
  lower = -Inf,
  upper = Inf,
  any.missing = TRUE,
  all.missing = TRUE,
  len = NULL,
  min.len = NULL,
  max.len = NULL,
  unique = FALSE,
  sorted = FALSE,
  names = NULL,
  typed.missing = FALSE,
  null.ok = FALSE
)

assertIntegerish(
  x,
  tol = sqrt(.Machine$double.eps),
  lower = -Inf,
  upper = Inf,
  any.missing = TRUE,
  all.missing = TRUE,
  len = NULL,
  min.len = NULL,
  max.len = NULL,
  unique = FALSE,
  sorted = FALSE,
  names = NULL,
  typed.missing = FALSE,
  null.ok = FALSE,
  coerce = FALSE,
  .var.name = vname(x),
  add = NULL
)

assert_integerish(
  x,
  tol = sqrt(.Machine$double.eps),
  lower = -Inf,
  upper = Inf,
  any.missing = TRUE,
  all.missing = TRUE,
  len = NULL,
  min.len = NULL,
  max.len = NULL,
  unique = FALSE,
  sorted = FALSE,
  names = NULL,
  typed.missing = FALSE,
  null.ok = FALSE,
  coerce = FALSE,
  .var.name = vname(x),
  add = NULL
)

testIntegerish(
  x,
  tol = sqrt(.Machine$double.eps),
  lower = -Inf,
  upper = Inf,
  any.missing = TRUE,
  all.missing = TRUE,
  len = NULL,
  min.len = NULL,
  max.len = NULL,
  unique = FALSE,
  sorted = FALSE,
  names = NULL,
  typed.missing = FALSE,
  null.ok = FALSE
)

test_integerish(
  x,
  tol = sqrt(.Machine$double.eps),
  lower = -Inf,
  upper = Inf,
  any.missing = TRUE,
  all.missing = TRUE,
  len = NULL,
  min.len = NULL,
  max.len = NULL,
  unique = FALSE,
  sorted = FALSE,
  names = NULL,
  typed.missing = FALSE,
  null.ok = FALSE
)

expect_integerish(
  x,
  tol = sqrt(.Machine$double.eps),
  lower = -Inf,
  upper = Inf,
  any.missing = TRUE,
  all.missing = TRUE,
  len = NULL,
  min.len = NULL,
  max.len = NULL,
  unique = FALSE,
  sorted = FALSE,
  names = NULL,
  typed.missing = FALSE,
  null.ok = FALSE,
  info = NULL,
  label = vname(x)
)
```

## Arguments

- x:

  \[`any`\]  
  Object to check.

- tol:

  \[`double(1)`\]  
  Numerical tolerance used to check whether a double or complex can be
  converted. Default is `sqrt(.Machine$double.eps)`.

- lower:

  \[`numeric(1)`\]  
  Lower value all elements of `x` must be greater than or equal to.

- upper:

  \[`numeric(1)`\]  
  Upper value all elements of `x` must be lower than or equal to.

- any.missing:

  \[`logical(1)`\]  
  Are vectors with missing values allowed? Default is `TRUE`.

- all.missing:

  \[`logical(1)`\]  
  Are vectors with no non-missing values allowed? Default is `TRUE`.
  Note that empty vectors do not have non-missing values.

- len:

  \[`integer(1)`\]  
  Exact expected length of `x`.

- min.len:

  \[`integer(1)`\]  
  Minimal length of `x`.

- max.len:

  \[`integer(1)`\]  
  Maximal length of `x`.

- unique:

  \[`logical(1)`\]  
  Must all values be unique? Default is `FALSE`.

- sorted:

  \[`logical(1)`\]  
  Elements must be sorted in ascending order. Missing values are
  ignored.

- names:

  \[`character(1)`\]  
  Check for names. See
  [`checkNamed`](https://mllg.github.io/checkmate/reference/checkNamed.md)
  for possible values. Default is “any” which performs no check at all.
  Note that you can use
  [`checkSubset`](https://mllg.github.io/checkmate/reference/checkSubset.md)
  to check for a specific set of names.

- typed.missing:

  \[`logical(1)`\]  
  If set to `FALSE` (default), all types of missing values (`NA`,
  `NA_integer_`, `NA_real_`, `NA_character_` or `NA_character_`) as well
  as empty vectors are allowed while type-checking atomic input. Set to
  `TRUE` to enable strict type checking.

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
functions `assertIntegerish`/`assert_integerish` return `x` invisibly,
whereas `checkIntegerish`/`check_integerish` and
`testIntegerish`/`test_integerish` return `TRUE`. If the check is not
successful, `assertIntegerish`/`assert_integerish` throws an error
message, `testIntegerish`/`test_integerish` returns `FALSE`, and
`checkIntegerish`/`check_integerish` return a string with the error
message. The function `expect_integerish` always returns an
[`expectation`](https://testthat.r-lib.org/reference/expectation.html).

## Details

This function does not distinguish between `NA`, `NA_integer_`,
`NA_real_`, `NA_complex_` `NA_character_` and `NaN`.

## Note

To convert from integerish to integer, use
[`asInteger`](https://mllg.github.io/checkmate/reference/asInteger.md).

## See also

Other basetypes:
[`checkArray()`](https://mllg.github.io/checkmate/reference/checkArray.md),
[`checkAtomic()`](https://mllg.github.io/checkmate/reference/checkAtomic.md),
[`checkAtomicVector()`](https://mllg.github.io/checkmate/reference/checkAtomicVector.md),
[`checkCharacter()`](https://mllg.github.io/checkmate/reference/checkCharacter.md),
[`checkComplex()`](https://mllg.github.io/checkmate/reference/checkComplex.md),
[`checkDataFrame()`](https://mllg.github.io/checkmate/reference/checkDataFrame.md),
[`checkDate()`](https://mllg.github.io/checkmate/reference/checkDate.md),
[`checkDouble()`](https://mllg.github.io/checkmate/reference/checkDouble.md),
[`checkEnvironment()`](https://mllg.github.io/checkmate/reference/checkEnvironment.md),
[`checkFactor()`](https://mllg.github.io/checkmate/reference/checkFactor.md),
[`checkFormula()`](https://mllg.github.io/checkmate/reference/checkFormula.md),
[`checkFunction()`](https://mllg.github.io/checkmate/reference/checkFunction.md),
[`checkInteger()`](https://mllg.github.io/checkmate/reference/checkInteger.md),
[`checkList()`](https://mllg.github.io/checkmate/reference/checkList.md),
[`checkLogical()`](https://mllg.github.io/checkmate/reference/checkLogical.md),
[`checkMatrix()`](https://mllg.github.io/checkmate/reference/checkMatrix.md),
[`checkNull()`](https://mllg.github.io/checkmate/reference/checkNull.md),
[`checkNumeric()`](https://mllg.github.io/checkmate/reference/checkNumeric.md),
[`checkPOSIXct()`](https://mllg.github.io/checkmate/reference/checkPOSIXct.md),
[`checkRaw()`](https://mllg.github.io/checkmate/reference/checkRaw.md),
[`checkVector()`](https://mllg.github.io/checkmate/reference/checkVector.md)

## Examples

``` r
testIntegerish(1L)
#> [1] TRUE
testIntegerish(1.)
#> [1] TRUE
testIntegerish(1:2, lower = 1L, upper = 2L, any.missing = FALSE)
#> [1] TRUE
```
