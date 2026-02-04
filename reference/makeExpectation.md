# Turn a Check into an Expectation

`makeExpectation` is the internal function used to evaluate the result
of a check and turn it into an
[`expectation`](https://testthat.r-lib.org/reference/expectation.html).
`makeExceptionFunction` can be used to automatically create an
expectation function based on a check function (see example).

## Usage

``` r
makeExpectation(x, res, info, label)

makeExpectationFunction(
  check.fun,
  c.fun = NULL,
  use.namespace = FALSE,
  env = parent.frame()
)
```

## Arguments

- x:

  \[`any`\]  
  Object to check.

- res:

  \[`TRUE` \| `character(1)`\]  
  The result of a check function: `TRUE` for successful checks, and an
  error message as string otherwise.

- info:

  \[`character(1)`\]  
  See
  [`expect_that`](https://testthat.r-lib.org/reference/expect_that.html)

- label:

  \[`character(1)`\]  
  See
  [`expect_that`](https://testthat.r-lib.org/reference/expect_that.html)

- check.fun:

  \[`function`\]  
  Function which checks the input. Must return `TRUE` on success and a
  string with the error message otherwise.

- c.fun:

  \[`character(1)`\]  
  If not `NULL`, instead of calling the function `check.fun`, use
  `.Call` to call a C function “c.fun” with the identical set of
  parameters. The C function must be registered as a native symbol, see
  [`.Call`](https://rdrr.io/r/base/CallExternal.html). Useful if
  `check.fun` is just a simple wrapper.

- use.namespace:

  \[`logical(1)`\]  
  Call functions of checkmate using its namespace explicitly. Can be set
  to `FALSE` so save some microseconds, but the checkmate package needs
  to be imported. Default is `TRUE`.

- env:

  \[`environment`\]  
  The environment of the created function. Default is the
  [`parent.frame`](https://rdrr.io/r/base/sys.parent.html).

## Value

`makeExpectation` invisibly returns the checked object.
`makeExpectationFunction` returns a `function`.

## See also

Other CustomConstructors:
[`makeAssertion()`](https://mllg.github.io/checkmate/reference/makeAssertion.md),
[`makeTest()`](https://mllg.github.io/checkmate/reference/makeTest.md)

## Examples

``` r
# Simple custom check function
checkFalse = function(x) if (!identical(x, FALSE)) "Must be FALSE" else TRUE

# Create the respective expect function
expect_false = function(x, info = NULL, label = vname(x)) {
  res = checkFalse(x)
  makeExpectation(x, res, info = info, label = label)
}

# Alternative: Automatically create such a function
expect_false = makeExpectationFunction(checkFalse)
print(expect_false)
#> function (x, info = NULL, label = vname(x)) 
#> {
#>     if (missing(x)) 
#>         stop(sprintf("Argument '%s' is missing", label))
#>     res = checkFalse(x)
#>     makeExpectation(x, res, info, label)
#> }
#> <environment: 0x5600be711be8>
```
