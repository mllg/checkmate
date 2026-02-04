# Check if an argument is FALSE

Simply checks if an argument is `FALSE`.

## Usage

``` r
checkFALSE(x, na.ok = FALSE)

check_false(x, na.ok = FALSE)

assertFALSE(x, na.ok = FALSE, .var.name = vname(x), add = NULL)

assert_false(x, na.ok = FALSE, .var.name = vname(x), add = NULL)

testFALSE(x, na.ok = FALSE)

test_false(x, na.ok = FALSE)
```

## Arguments

- x:

  \[`any`\]  
  Object to check.

- na.ok:

  \[`logical(1)`\]  
  Are missing values allowed? Default is `FALSE`.

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
functions `assertFALSE.`/`assert_false.` return `x` invisibly, whereas
`checkFALSE.`/`check_false.` and `testFALSE.`/`test_false.` return
`TRUE`. If the check is not successful, `assertFALSE.`/`assert_false.`
throws an error message, `testFALSE.`/`test_false.` returns `FALSE`, and
`checkFALSE.`/`check_false.` return a string with the error message. The
function `expect_false.` always returns an
[`expectation`](https://testthat.r-lib.org/reference/expectation.html).

## Examples

``` r
testFALSE(FALSE)
#> [1] TRUE
testFALSE(TRUE)
#> [1] FALSE
```
