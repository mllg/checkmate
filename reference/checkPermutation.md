# Check if the arguments are permutations of each other.

In contrast to
[`checkSetEqual`](https://mllg.github.io/checkmate/reference/checkSetEqual.md),
the function tests for a true permutation of the two vectors and also
considers duplicated values. Missing values are being treated as actual
values by default. Does not work on raw values.

## Usage

``` r
checkPermutation(x, y, na.ok = TRUE)

check_permutation(x, y, na.ok = TRUE)

assertPermutation(x, y, na.ok = TRUE, .var.name = vname(x), add = NULL)

assert_permutation(x, y, na.ok = TRUE, .var.name = vname(x), add = NULL)

testPermutation(x, y, na.ok = TRUE)

test_permutation(x, y, na.ok = TRUE)

expect_permutation(x, y, na.ok = TRUE, info = NULL, label = vname(x))
```

## Arguments

- x:

  \[`any`\]  
  Object to check.

- y:

  \[`atomic`\]  
  Vector to compare with. Atomic vector of type other than raw.

- na.ok:

  \[`logical(1)`\]  
  Are missing values allowed? Default is `TRUE`.

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
functions `assertPermutation`/`assert_permutation` return `x` invisibly,
whereas `checkPermutation`/`check_permutation` and
`testPermutation`/`test_permutation` return `TRUE`. If the check is not
successful, `assertPermutation`/`assert_permutation` throws an error
message, `testPermutation`/`test_permutation` returns `FALSE`, and
`checkPermutation`/`check_permutation` return a string with the error
message. The function `expect_permutation` always returns an
[`expectation`](https://testthat.r-lib.org/reference/expectation.html).

## Note

The object `x` must be of the same type as the set w.r.t.
[`typeof`](https://rdrr.io/r/base/typeof.html). Integers and doubles are
both treated as numeric.

## See also

Other set:
[`checkChoice()`](https://mllg.github.io/checkmate/reference/checkChoice.md),
[`checkDisjunct()`](https://mllg.github.io/checkmate/reference/checkDisjunct.md),
[`checkSetEqual()`](https://mllg.github.io/checkmate/reference/checkSetEqual.md),
[`checkSubset()`](https://mllg.github.io/checkmate/reference/checkSubset.md)

## Examples

``` r
testPermutation(letters[1:2], letters[2:1])
#> [1] TRUE
testPermutation(letters[c(1, 1, 2)], letters[1:2])
#> [1] FALSE
testPermutation(c(NA, 1, 2), c(1, 2, NA))
#> [1] TRUE
testPermutation(c(NA, 1, 2), c(1, 2, NA), na.ok = FALSE)
#> [1] FALSE
```
