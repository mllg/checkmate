# Check if an argument is a tibble

Check if an argument is a tibble

## Usage

``` r
checkTibble(
  x,
  types = character(0L),
  any.missing = TRUE,
  all.missing = TRUE,
  min.rows = NULL,
  max.rows = NULL,
  min.cols = NULL,
  max.cols = NULL,
  nrows = NULL,
  ncols = NULL,
  row.names = NULL,
  col.names = NULL,
  null.ok = FALSE
)

check_tibble(
  x,
  types = character(0L),
  any.missing = TRUE,
  all.missing = TRUE,
  min.rows = NULL,
  max.rows = NULL,
  min.cols = NULL,
  max.cols = NULL,
  nrows = NULL,
  ncols = NULL,
  row.names = NULL,
  col.names = NULL,
  null.ok = FALSE
)

assertTibble(
  x,
  types = character(0L),
  any.missing = TRUE,
  all.missing = TRUE,
  min.rows = NULL,
  max.rows = NULL,
  min.cols = NULL,
  max.cols = NULL,
  nrows = NULL,
  ncols = NULL,
  row.names = NULL,
  col.names = NULL,
  null.ok = FALSE,
  .var.name = vname(x),
  add = NULL
)

assert_tibble(
  x,
  types = character(0L),
  any.missing = TRUE,
  all.missing = TRUE,
  min.rows = NULL,
  max.rows = NULL,
  min.cols = NULL,
  max.cols = NULL,
  nrows = NULL,
  ncols = NULL,
  row.names = NULL,
  col.names = NULL,
  null.ok = FALSE,
  .var.name = vname(x),
  add = NULL
)

testTibble(
  x,
  types = character(0L),
  any.missing = TRUE,
  all.missing = TRUE,
  min.rows = NULL,
  max.rows = NULL,
  min.cols = NULL,
  max.cols = NULL,
  nrows = NULL,
  ncols = NULL,
  row.names = NULL,
  col.names = NULL,
  null.ok = FALSE
)

test_tibble(
  x,
  types = character(0L),
  any.missing = TRUE,
  all.missing = TRUE,
  min.rows = NULL,
  max.rows = NULL,
  min.cols = NULL,
  max.cols = NULL,
  nrows = NULL,
  ncols = NULL,
  row.names = NULL,
  col.names = NULL,
  null.ok = FALSE
)

expect_tibble(
  x,
  types = character(0L),
  any.missing = TRUE,
  all.missing = TRUE,
  min.rows = NULL,
  max.rows = NULL,
  min.cols = NULL,
  max.cols = NULL,
  nrows = NULL,
  ncols = NULL,
  row.names = NULL,
  col.names = NULL,
  null.ok = FALSE,
  info = NULL,
  label = vname(x)
)
```

## Arguments

- x:

  \[`any`\]  
  Object to check.

- types:

  \[`character`\]  
  Character vector of class names. Each list element must inherit from
  at least one of the provided types. The types “logical”, “integer”,
  “integerish”, “double”, “numeric”, “complex”, “character”, “factor”,
  “atomic”, “vector” “atomicvector”, “array”, “matrix”, “list”,
  “function”, “environment” and “null” are supported. For other types
  [`inherits`](https://rdrr.io/r/base/class.html) is used as a fallback
  to check `x`'s inheritance. Defaults to `character(0)` (no check).

- any.missing:

  \[`logical(1)`\]  
  Are missing values allowed? Default is `TRUE`.

- all.missing:

  \[`logical(1)`\]  
  Are matrices with only missing values allowed? Default is `TRUE`.

- min.rows:

  \[`integer(1)`\]  
  Minimum number of rows.

- max.rows:

  \[`integer(1)`\]  
  Maximum number of rows.

- min.cols:

  \[`integer(1)`\]  
  Minimum number of columns.

- max.cols:

  \[`integer(1)`\]  
  Maximum number of columns.

- nrows:

  \[`integer(1)`\]  
  Exact number of rows.

- ncols:

  \[`integer(1)`\]  
  Exact number of columns.

- row.names:

  \[`character(1)`\]  
  Check for row names. Default is “NULL” (no check). See
  [`checkNamed`](https://mllg.github.io/checkmate/reference/checkNamed.md)
  for possible values. Note that you can use
  [`checkSubset`](https://mllg.github.io/checkmate/reference/checkSubset.md)
  to check for a specific set of names.

- col.names:

  \[`character(1)`\]  
  Check for column names. Default is “NULL” (no check). See
  [`checkNamed`](https://mllg.github.io/checkmate/reference/checkNamed.md)
  for possible values. Note that you can use
  [`checkSubset`](https://mllg.github.io/checkmate/reference/checkSubset.md)
  to test for a specific set of names.

- null.ok:

  \[`logical(1)`\]  
  If set to `TRUE`, `x` may also be `NULL`. In this case only a type
  check of `x` is performed, all additional checks are disabled.

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
functions `assertTibble`/`assert_tibble` return `x` invisibly, whereas
`checkTibble`/`check_tibble` and `testTibble`/`test_tibble` return
`TRUE`. If the check is not successful, `assertTibble`/`assert_tibble`
throws an error message, `testTibble`/`test_tibble` returns `FALSE`, and
`checkTibble`/`check_tibble` return a string with the error message. The
function `expect_tibble` always returns an
[`expectation`](https://testthat.r-lib.org/reference/expectation.html).

## See also

Other compound:
[`checkArray()`](https://mllg.github.io/checkmate/reference/checkArray.md),
[`checkDataFrame()`](https://mllg.github.io/checkmate/reference/checkDataFrame.md),
[`checkDataTable()`](https://mllg.github.io/checkmate/reference/checkDataTable.md),
[`checkMatrix()`](https://mllg.github.io/checkmate/reference/checkMatrix.md)

## Examples

``` r
library(tibble)
x = as_tibble(iris)
testTibble(x)
#> [1] TRUE
testTibble(x, nrow = 150, any.missing = FALSE)
#> [1] TRUE
```
