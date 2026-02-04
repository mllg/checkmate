# Turn a Check into a Test

`makeTest` is the internal function used to evaluate the result of a
check and throw an exception if necessary. This function is currently
only a stub and just calls
[`isTRUE`](https://rdrr.io/r/base/Logic.html). `makeTestFunction` can be
used to automatically create an assertion function based on a check
function (see example).

## Usage

``` r
makeTest(res)

makeTestFunction(check.fun, c.fun = NULL, env = parent.frame())
```

## Arguments

- res:

  \[`TRUE` \| `character(1)`\]  
  The result of a check function: `TRUE` for successful checks, and an
  error message as string otherwise.

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

- env:

  \[`environment`\]  
  The environment of the created function. Default is the
  [`parent.frame`](https://rdrr.io/r/base/sys.parent.html).

## Value

`makeTest` returns `TRUE` if the check is successful and `FALSE`
otherwise. `makeTestFunction` returns a `function`.

## See also

Other CustomConstructors:
[`makeAssertion()`](https://mllg.github.io/checkmate/reference/makeAssertion.md),
[`makeExpectation()`](https://mllg.github.io/checkmate/reference/makeExpectation.md)

## Examples

``` r
# Simple custom check function
checkFalse = function(x) if (!identical(x, FALSE)) "Must be FALSE" else TRUE

# Create the respective test function
testFalse = function(x) {
  res = checkFalse(x)
  makeTest(res)
}

# Alternative: Automatically create such a function
testFalse = makeTestFunction(checkFalse)
print(testFalse)
#> function (x) 
#> {
#>     isTRUE(checkFalse(x))
#> }
#> <environment: 0x55f48d0070b0>
```
