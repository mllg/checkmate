# Check if an argument is an array

Check if an argument is an array

## Usage

``` r
checkArray(
  x,
  mode = NULL,
  any.missing = TRUE,
  d = NULL,
  min.d = NULL,
  max.d = NULL,
  null.ok = FALSE
)

check_array(
  x,
  mode = NULL,
  any.missing = TRUE,
  d = NULL,
  min.d = NULL,
  max.d = NULL,
  null.ok = FALSE
)

assertArray(
  x,
  mode = NULL,
  any.missing = TRUE,
  d = NULL,
  min.d = NULL,
  max.d = NULL,
  null.ok = FALSE,
  .var.name = vname(x),
  add = NULL
)

assert_array(
  x,
  mode = NULL,
  any.missing = TRUE,
  d = NULL,
  min.d = NULL,
  max.d = NULL,
  null.ok = FALSE,
  .var.name = vname(x),
  add = NULL
)

testArray(
  x,
  mode = NULL,
  any.missing = TRUE,
  d = NULL,
  min.d = NULL,
  max.d = NULL,
  null.ok = FALSE
)

test_array(
  x,
  mode = NULL,
  any.missing = TRUE,
  d = NULL,
  min.d = NULL,
  max.d = NULL,
  null.ok = FALSE
)

expect_array(
  x,
  mode = NULL,
  any.missing = TRUE,
  d = NULL,
  min.d = NULL,
  max.d = NULL,
  null.ok = FALSE,
  info = NULL,
  label = vname(x)
)
```

## Arguments

- x:

  \[`any`\]  
  Object to check.

- mode:

  \[`character(1)`\]  
  Storage mode of the array. Arrays can hold vectors, i.e. “logical”,
  “integer”, “integerish”, “double”, “numeric”, “complex”, “character”
  and “list”. You can also specify “atomic” here to explicitly prohibit
  lists. Default is `NULL` (no check). If all values of `x` are missing,
  this check is skipped.

- any.missing:

  \[`logical(1)`\]  
  Are missing values allowed? Default is `TRUE`.

- d:

  \[`integer(1)`\]  
  Exact number of dimensions of array `x`. Default is `NULL` (no check).

- min.d:

  \[`integer(1)`\]  
  Minimum number of dimensions of array `x`. Default is `NULL` (no
  check).

- max.d:

  \[`integer(1)`\]  
  Maximum number of dimensions of array `x`. Default is `NULL` (no
  check).

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
functions `assertArray`/`assert_array` return `x` invisibly, whereas
`checkArray`/`check_array` and `testArray`/`test_array` return `TRUE`.
If the check is not successful, `assertArray`/`assert_array` throws an
error message, `testArray`/`test_array` returns `FALSE`, and
`checkArray`/`check_array` return a string with the error message. The
function `expect_array` always returns an
[`expectation`](https://testthat.r-lib.org/reference/expectation.html).

## See also

Other basetypes:
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
[`checkIntegerish()`](https://mllg.github.io/checkmate/reference/checkIntegerish.md),
[`checkList()`](https://mllg.github.io/checkmate/reference/checkList.md),
[`checkLogical()`](https://mllg.github.io/checkmate/reference/checkLogical.md),
[`checkMatrix()`](https://mllg.github.io/checkmate/reference/checkMatrix.md),
[`checkNull()`](https://mllg.github.io/checkmate/reference/checkNull.md),
[`checkNumeric()`](https://mllg.github.io/checkmate/reference/checkNumeric.md),
[`checkPOSIXct()`](https://mllg.github.io/checkmate/reference/checkPOSIXct.md),
[`checkRaw()`](https://mllg.github.io/checkmate/reference/checkRaw.md),
[`checkVector()`](https://mllg.github.io/checkmate/reference/checkVector.md)

Other compound:
[`checkDataFrame()`](https://mllg.github.io/checkmate/reference/checkDataFrame.md),
[`checkDataTable()`](https://mllg.github.io/checkmate/reference/checkDataTable.md),
[`checkMatrix()`](https://mllg.github.io/checkmate/reference/checkMatrix.md),
[`checkTibble()`](https://mllg.github.io/checkmate/reference/checkTibble.md)

## Examples

``` r
checkArray(array(1:27, dim = c(3, 3, 3)), d = 3)
#> [1] TRUE
```
