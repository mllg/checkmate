# Check if an argument is named

Check if an argument is named

## Usage

``` r
checkNamed(x, type = "named")

check_named(x, type = "named")

assertNamed(x, type = "named", .var.name = vname(x), add = NULL)

assert_named(x, type = "named", .var.name = vname(x), add = NULL)

testNamed(x, type = "named")

test_named(x, type = "named")
```

## Arguments

- x:

  \[`any`\]  
  Object to check.

- type:

  \[`character(1)`\]  
  Select the check(s) to perform. “unnamed” checks `x` to be unnamed.
  “named” (default) checks `x` to be named which excludes names to be
  `NA` or empty (`""`). “unique” additionally tests for non-duplicated
  names. “strict” checks for unique names which comply to R's variable
  name restrictions. Note that for zero-length `x` every name check
  evaluates to `TRUE`.

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
functions `assertNamed`/`assert_named` return `x` invisibly, whereas
`checkNamed`/`check_named` and `testNamed`/`test_named` return `TRUE`.
If the check is not successful, `assertNamed`/`assert_named` throws an
error message, `testNamed`/`test_named` returns `FALSE`, and
`checkNamed`/`check_named` return a string with the error message. The
function `expect_named` always returns an
[`expectation`](https://testthat.r-lib.org/reference/expectation.html).

## Note

These function are deprecated and will be removed in a future version.
Please use
[`checkNames`](https://mllg.github.io/checkmate/reference/checkNames.md)
instead.

## See also

Other attributes:
[`checkClass()`](https://mllg.github.io/checkmate/reference/checkClass.md),
[`checkMultiClass()`](https://mllg.github.io/checkmate/reference/checkMultiClass.md),
[`checkNames()`](https://mllg.github.io/checkmate/reference/checkNames.md)

## Examples

``` r
x = 1:3
testNamed(x, "unnamed")
#> [1] TRUE
names(x) = letters[1:3]
testNamed(x, "unique")
#> [1] TRUE
```
