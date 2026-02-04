# Check if an argument is NULL

Check if an argument is NULL

## Usage

``` r
checkNull(x)

check_null(x)

assertNull(x, .var.name = vname(x), add = NULL)

assert_null(x, .var.name = vname(x), add = NULL)

testNull(x)

test_null(x)
```

## Arguments

- x:

  \[`any`\]  
  Object to check.

- .var.name:

  \[`character(1)`\]  
  Name of the checked object to print in assertions. Defaults to the
  heuristic implemented in
  [`vname`](https://mllg.github.io/checkmate/reference/vname.md).

- add:

  \[`AssertCollection`\]  
  Collection to store assertion messages. See
  [`AssertCollection`](https://mllg.github.io/checkmate/reference/AssertCollection.md).

## Value

Depending on the function prefix: If the check is successful, the
functions `assertNull`/`assert_null` return `x` invisibly, whereas
`checkNull`/`check_null` and `testNull`/`test_null` return `TRUE`. If
the check is not successful, `assertNull`/`assert_null` throws an error
message, `testNull`/`test_null` returns `FALSE`, and
`checkNull`/`check_null` return a string with the error message. The
function `expect_null` always returns an
[`expectation`](https://testthat.r-lib.org/reference/expectation.html).

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
[`checkIntegerish()`](https://mllg.github.io/checkmate/reference/checkIntegerish.md),
[`checkList()`](https://mllg.github.io/checkmate/reference/checkList.md),
[`checkLogical()`](https://mllg.github.io/checkmate/reference/checkLogical.md),
[`checkMatrix()`](https://mllg.github.io/checkmate/reference/checkMatrix.md),
[`checkNumeric()`](https://mllg.github.io/checkmate/reference/checkNumeric.md),
[`checkPOSIXct()`](https://mllg.github.io/checkmate/reference/checkPOSIXct.md),
[`checkRaw()`](https://mllg.github.io/checkmate/reference/checkRaw.md),
[`checkVector()`](https://mllg.github.io/checkmate/reference/checkVector.md)

## Examples

``` r
testNull(NULL)
#> [1] TRUE
testNull(1)
#> [1] FALSE
```
