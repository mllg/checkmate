# Turn a Check into an Assertion

`makeAssertion` is the internal function used to evaluate the result of
a check and throw an exception if necessary. `makeAssertionFunction` can
be used to automatically create an assertion function based on a check
function (see example).

## Usage

``` r
makeAssertion(x, res, var.name, collection)

makeAssertionFunction(
  check.fun,
  c.fun = NULL,
  use.namespace = TRUE,
  coerce = FALSE,
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

- var.name:

  \[`character(1)`\]  
  The custom name for `x` as passed to any `assert*` function. Defaults
  to a heuristic name lookup.

- collection:

  \[[`AssertCollection`](https://mllg.github.io/checkmate/reference/AssertCollection.md)\]  
  If an
  [`AssertCollection`](https://mllg.github.io/checkmate/reference/AssertCollection.md)
  is provided, the error message is stored in it. If `NULL`, an
  exception is raised if `res` is not `TRUE`.

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

- coerce:

  \[`logical(1)`\]  
  If `TRUE`, injects some lines of code to convert numeric values to
  integer after an successful assertion. Currently used in
  [`assertCount`](https://mllg.github.io/checkmate/reference/checkCount.md),
  [`assertInt`](https://mllg.github.io/checkmate/reference/checkInt.md)
  and
  [`assertIntegerish`](https://mllg.github.io/checkmate/reference/checkIntegerish.md).

- env:

  \[`environment`\]  
  The environment of the created function. Default is the
  [`parent.frame`](https://rdrr.io/r/base/sys.parent.html).

## Value

`makeAssertion` invisibly returns the checked object if the check was
successful, and an exception is raised (or its message stored in the
collection) otherwise. `makeAssertionFunction` returns a `function`.

## See also

Other CustomConstructors:
[`makeExpectation()`](https://mllg.github.io/checkmate/reference/makeExpectation.md),
[`makeTest()`](https://mllg.github.io/checkmate/reference/makeTest.md)

## Examples

``` r
# Simple custom check function
checkFalse = function(x) if (!identical(x, FALSE)) "Must be FALSE" else TRUE

# Create the respective assert function
assertFalse = function(x, .var.name = vname(x), add = NULL) {
  res = checkFalse(x)
  makeAssertion(x, res, .var.name, add)
}

# Alternative: Automatically create such a function
assertFalse = makeAssertionFunction(checkFalse)
print(assertFalse)
#> function (x, .var.name = checkmate::vname(x), add = NULL) 
#> {
#>     if (missing(x)) 
#>         stop(sprintf("argument \"%s\" is missing, with no default", 
#>             .var.name))
#>     res = checkFalse(x)
#>     checkmate::makeAssertion(x, res, .var.name, add)
#> }
#> <environment: 0x55f48c835b48>
```
