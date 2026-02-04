# Check if an object is an element of a given set

Check if an object is an element of a given set

## Usage

``` r
checkChoice(x, choices, null.ok = FALSE, fmatch = FALSE)

check_choice(x, choices, null.ok = FALSE, fmatch = FALSE)

assertChoice(
  x,
  choices,
  null.ok = FALSE,
  fmatch = FALSE,
  .var.name = vname(x),
  add = NULL
)

assert_choice(
  x,
  choices,
  null.ok = FALSE,
  fmatch = FALSE,
  .var.name = vname(x),
  add = NULL
)

testChoice(x, choices, null.ok = FALSE, fmatch = FALSE)

test_choice(x, choices, null.ok = FALSE, fmatch = FALSE)

expect_choice(
  x,
  choices,
  null.ok = FALSE,
  fmatch = FALSE,
  info = NULL,
  label = vname(x)
)
```

## Arguments

- x:

  \[`any`\]  
  Object to check.

- choices:

  \[`atomic`\]  
  Set of possible values.

- null.ok:

  \[`logical(1)`\]  
  If set to `TRUE`, `x` may also be `NULL`. In this case only a type
  check of `x` is performed, all additional checks are disabled.

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
functions `assertChoice`/`assert_choice` return `x` invisibly, whereas
`checkChoice`/`check_choice` and `testChoice`/`test_choice` return
`TRUE`. If the check is not successful, `assertChoice`/`assert_choice`
throws an error message, `testChoice`/`test_choice` returns `FALSE`, and
`checkChoice`/`check_choice` return a string with the error message. The
function `expect_choice` always returns an
[`expectation`](https://testthat.r-lib.org/reference/expectation.html).

## Note

The object `x` must be of the same type as the set w.r.t.
[`typeof`](https://rdrr.io/r/base/typeof.html). Integers and doubles are
both treated as numeric.

## See also

Other set:
[`checkDisjunct()`](https://mllg.github.io/checkmate/reference/checkDisjunct.md),
[`checkPermutation()`](https://mllg.github.io/checkmate/reference/checkPermutation.md),
[`checkSetEqual()`](https://mllg.github.io/checkmate/reference/checkSetEqual.md),
[`checkSubset()`](https://mllg.github.io/checkmate/reference/checkSubset.md)

## Examples

``` r
testChoice("x", letters)
#> [1] TRUE

# x is not converted before the comparison (except for numerics)
testChoice(factor("a"), "a")
#> [1] FALSE
testChoice(1, "1")
#> [1] FALSE
testChoice(1, as.integer(1))
#> [1] TRUE
```
