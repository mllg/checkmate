# Check that an argument is an atomic vector

For the definition of “atomic”, see
[`is.atomic`](https://rdrr.io/r/base/is.recursive.html).

Note that \`NULL\` is recognized as a valid atomic value, as in R
versions up to version 4.3.x. For details, see
<https://stat.ethz.ch/pipermail/r-devel/2023-September/082892.html>.

## Usage

``` r
checkAtomic(
  x,
  any.missing = TRUE,
  all.missing = TRUE,
  len = NULL,
  min.len = NULL,
  max.len = NULL,
  unique = FALSE,
  names = NULL
)

check_atomic(
  x,
  any.missing = TRUE,
  all.missing = TRUE,
  len = NULL,
  min.len = NULL,
  max.len = NULL,
  unique = FALSE,
  names = NULL
)

assertAtomic(
  x,
  any.missing = TRUE,
  all.missing = TRUE,
  len = NULL,
  min.len = NULL,
  max.len = NULL,
  unique = FALSE,
  names = NULL,
  .var.name = vname(x),
  add = NULL
)

assert_atomic(
  x,
  any.missing = TRUE,
  all.missing = TRUE,
  len = NULL,
  min.len = NULL,
  max.len = NULL,
  unique = FALSE,
  names = NULL,
  .var.name = vname(x),
  add = NULL
)

testAtomic(
  x,
  any.missing = TRUE,
  all.missing = TRUE,
  len = NULL,
  min.len = NULL,
  max.len = NULL,
  unique = FALSE,
  names = NULL
)

test_atomic(
  x,
  any.missing = TRUE,
  all.missing = TRUE,
  len = NULL,
  min.len = NULL,
  max.len = NULL,
  unique = FALSE,
  names = NULL
)

expect_atomic(
  x,
  any.missing = TRUE,
  all.missing = TRUE,
  len = NULL,
  min.len = NULL,
  max.len = NULL,
  unique = FALSE,
  names = NULL,
  info = NULL,
  label = vname(x)
)
```

## Arguments

- x:

  \[`any`\]  
  Object to check.

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

- names:

  \[`character(1)`\]  
  Check for names. See
  [`checkNamed`](https://mllg.github.io/checkmate/reference/checkNamed.md)
  for possible values. Default is “any” which performs no check at all.
  Note that you can use
  [`checkSubset`](https://mllg.github.io/checkmate/reference/checkSubset.md)
  to check for a specific set of names.

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
functions `assertAtomic`/`assert_atomic` return `x` invisibly, whereas
`checkAtomic`/`check_atomic` and `testAtomic`/`test_atomic` return
`TRUE`. If the check is not successful, `assertAtomic`/`assert_atomic`
throws an error message, `testAtomic`/`test_atomic` returns `FALSE`, and
`checkAtomic`/`check_atomic` return a string with the error message. The
function `expect_atomic` always returns an
[`expectation`](https://testthat.r-lib.org/reference/expectation.html).

## See also

Other basetypes:
[`checkArray()`](https://mllg.github.io/checkmate/reference/checkArray.md),
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
[`checkIntegerish()`](https://mllg.github.io/checkmate/reference/checkIntegerish.md),
[`checkList()`](https://mllg.github.io/checkmate/reference/checkList.md),
[`checkLogical()`](https://mllg.github.io/checkmate/reference/checkLogical.md),
[`checkMatrix()`](https://mllg.github.io/checkmate/reference/checkMatrix.md),
[`checkNull()`](https://mllg.github.io/checkmate/reference/checkNull.md),
[`checkNumeric()`](https://mllg.github.io/checkmate/reference/checkNumeric.md),
[`checkPOSIXct()`](https://mllg.github.io/checkmate/reference/checkPOSIXct.md),
[`checkRaw()`](https://mllg.github.io/checkmate/reference/checkRaw.md),
[`checkVector()`](https://mllg.github.io/checkmate/reference/checkVector.md)

Other atomicvector:
[`checkAtomicVector()`](https://mllg.github.io/checkmate/reference/checkAtomicVector.md),
[`checkVector()`](https://mllg.github.io/checkmate/reference/checkVector.md)

## Examples

``` r
testAtomic(letters, min.len = 1L, any.missing = FALSE)
#> [1] TRUE
```
