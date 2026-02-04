# Check if an argument is equal to a given set

Check if an argument is equal to a given set

## Usage

``` r
checkSetEqual(x, y, ordered = FALSE, fmatch = FALSE)

check_set_equal(x, y, ordered = FALSE, fmatch = FALSE)

assertSetEqual(
  x,
  y,
  ordered = FALSE,
  fmatch = FALSE,
  .var.name = vname(x),
  add = NULL
)

assert_set_equal(
  x,
  y,
  ordered = FALSE,
  fmatch = FALSE,
  .var.name = vname(x),
  add = NULL
)

testSetEqual(x, y, ordered = FALSE, fmatch = FALSE)

test_set_equal(x, y, ordered = FALSE, fmatch = FALSE)

expect_set_equal(
  x,
  y,
  ordered = FALSE,
  fmatch = FALSE,
  info = NULL,
  label = vname(x)
)
```

## Arguments

- x:

  \[`any`\]  
  Object to check.

- y:

  \[`atomic`\]  
  Set to compare with.

- ordered:

  \[`logical(1)`\]  
  Check `x` to have the same length and order as `y`, i.e. check using
  “==” while handling `NA`s nicely. Default is `FALSE`.

- fmatch:

  \[`logical(1)`\]  
  Use the set operations implemented in
  [`fmatch`](https://rdrr.io/pkg/fastmatch/man/fmatch.html) in package
  fastmatch. If fastmatch is not installed, this silently falls back to
  [`match`](https://rdrr.io/r/base/match.html).
  [`fmatch`](https://rdrr.io/pkg/fastmatch/man/fmatch.html) modifies `y`
  by reference: A hash table is added as attribute which is used in
  subsequent calls.

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
functions `assertSubset`/`assert_subset` return `x` invisibly, whereas
`checkSubset`/`check_subset` and `testSubset`/`test_subset` return
`TRUE`. If the check is not successful, `assertSubset`/`assert_subset`
throws an error message, `testSubset`/`test_subset` returns `FALSE`, and
`checkSubset`/`check_subset` return a string with the error message. The
function `expect_subset` always returns an
[`expectation`](https://testthat.r-lib.org/reference/expectation.html).

## Note

The object `x` must be of the same type as the set w.r.t.
[`typeof`](https://rdrr.io/r/base/typeof.html). Integers and doubles are
both treated as numeric.

## See also

Other set:
[`checkChoice()`](https://mllg.github.io/checkmate/reference/checkChoice.md),
[`checkDisjunct()`](https://mllg.github.io/checkmate/reference/checkDisjunct.md),
[`checkPermutation()`](https://mllg.github.io/checkmate/reference/checkPermutation.md),
[`checkSubset()`](https://mllg.github.io/checkmate/reference/checkSubset.md)

## Examples

``` r
testSetEqual(c("a", "b"), c("a", "b"))
#> [1] TRUE
testSetEqual(1:3, 1:4)
#> [1] FALSE

# x is not converted before the comparison (except for numerics)
testSetEqual(factor("a"), "a")
#> [1] FALSE
testSetEqual(1, "1")
#> [1] FALSE
testSetEqual(1, as.integer(1))
#> [1] TRUE
```
