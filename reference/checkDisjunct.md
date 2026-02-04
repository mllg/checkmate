# Check if an argument is disjunct from a given set

Check if an argument is disjunct from a given set

## Usage

``` r
checkDisjunct(x, y, fmatch = FALSE)

check_disjunct(x, y, fmatch = FALSE)

assertDisjunct(x, y, fmatch = FALSE, .var.name = vname(x), add = NULL)

assert_disjunct(x, y, fmatch = FALSE, .var.name = vname(x), add = NULL)

testDisjunct(x, y, fmatch = FALSE)

test_disjunct(x, y, fmatch = FALSE)

expect_disjunct(x, y, fmatch = FALSE, info = NULL, label = vname(x))
```

## Arguments

- x:

  \[`any`\]  
  Object to check.

- y:

  \[`atomic`\]  
  Other Set.

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
functions `assertDisjunct`/`assert_disjunct` return `x` invisibly,
whereas `checkDisjunct`/`check_disjunct` and
`testDisjunct`/`test_disjunct` return `TRUE`. If the check is not
successful, `assertDisjunct`/`assert_disjunct` throws an error message,
`testDisjunct`/`test_disjunct` returns `FALSE`, and
`checkDisjunct`/`check_disjunct` return a string with the error message.
The function `expect_disjunct` always returns an
[`expectation`](https://testthat.r-lib.org/reference/expectation.html).

## Note

The object `x` must be of the same type as the set w.r.t.
[`typeof`](https://rdrr.io/r/base/typeof.html). Integers and doubles are
both treated as numeric.

## See also

Other set:
[`checkChoice()`](https://mllg.github.io/checkmate/reference/checkChoice.md),
[`checkPermutation()`](https://mllg.github.io/checkmate/reference/checkPermutation.md),
[`checkSetEqual()`](https://mllg.github.io/checkmate/reference/checkSetEqual.md),
[`checkSubset()`](https://mllg.github.io/checkmate/reference/checkSubset.md)

## Examples

``` r
testDisjunct(1L, letters)
#> [1] TRUE
testDisjunct(c("a", "z"), letters)
#> [1] FALSE

# x is not converted before the comparison (except for numerics)
testDisjunct(factor("a"), "a")
#> [1] FALSE
testDisjunct(1, "1")
#> [1] FALSE
testDisjunct(1, as.integer(1))
#> [1] FALSE
```
