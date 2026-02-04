# Quick recursive arguments checks on lists and data frames

These functions are the tuned counterparts of
[`qtest`](https://mllg.github.io/checkmate/reference/qassert.md),
[`qassert`](https://mllg.github.io/checkmate/reference/qassert.md) and
[`qexpect`](https://mllg.github.io/checkmate/reference/qassert.md)
tailored for recursive checks of list elements or data frame columns.

## Usage

``` r
qassertr(x, rules, .var.name = vname(x))

qtestr(x, rules, depth = 1L)

qexpectr(x, rules, info = NULL, label = vname(x))
```

## Arguments

- x:

  \[`list` or `data.frame`\]  
  List or data frame to check for compliance with at least one of
  `rules`. See details of
  [`qtest`](https://mllg.github.io/checkmate/reference/qassert.md) for
  rule explanation.

- rules:

  \[`character`\]  
  Set of rules. See
  [`qtest`](https://mllg.github.io/checkmate/reference/qassert.md)

- .var.name:

  \[`character(1)`\]  
  Name of the checked object to print in error messages. Defaults to the
  heuristic implemented in
  [`vname`](https://mllg.github.io/checkmate/reference/vname.md).

- depth:

  \[`integer(1)`\]  
  Maximum recursion depth. Defaults to “1” to directly check list
  elements or data frame columns. Set to a higher value to check lists
  of lists of elements.

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

See [`qassert`](https://mllg.github.io/checkmate/reference/qassert.md).

## See also

[`qtest`](https://mllg.github.io/checkmate/reference/qassert.md),
[`qassert`](https://mllg.github.io/checkmate/reference/qassert.md)

## Examples

``` r
# All list elements are integers with length >= 1?
qtestr(as.list(1:10), "i+")
#> [1] TRUE

# All list elements (i.e. data frame columns) are numeric?
qtestr(iris, "n")
#> [1] FALSE

# All list elements are numeric, w/o NAs?
qtestr(list(a = 1:3, b = rnorm(1), c = letters), "N+")
#> [1] FALSE

# All list elements are numeric OR character
qtestr(list(a = 1:3, b = rnorm(1), c = letters), c("N+", "S+"))
#> [1] TRUE
```
