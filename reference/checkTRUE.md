# Check if an argument is TRUE

Simply checks if an argument is `TRUE`.

## Usage

``` r
checkTRUE(x, na.ok = FALSE)

check_true(x, na.ok = FALSE)

assertTRUE(x, na.ok = FALSE, .var.name = vname(x), add = NULL)

assert_true(x, na.ok = FALSE, .var.name = vname(x), add = NULL)

testTRUE(x, na.ok = FALSE)

test_true(x, na.ok = FALSE)
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
functions `assertTRUE.`/`assert_true.` return `x` invisibly, whereas
`checkTRUE.`/`check_true.` and `testTRUE.`/`test_true.` return `TRUE`.
If the check is not successful, `assertTRUE.`/`assert_true.` throws an
error message, `testTRUE.`/`test_true.` returns `FALSE`, and
`checkTRUE.`/`check_true.` return a string with the error message. The
function `expect_true.` always returns an
[`expectation`](https://testthat.r-lib.org/reference/expectation.html).

## Examples

``` r
testTRUE(TRUE)
#> [1] TRUE
testTRUE(FALSE)
#> [1] FALSE
```
