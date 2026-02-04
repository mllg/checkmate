# Check names to comply to specific rules

Performs various checks on character vectors, usually names.

## Usage

``` r
checkNames(
  x,
  type = "named",
  subset.of = NULL,
  must.include = NULL,
  permutation.of = NULL,
  identical.to = NULL,
  disjunct.from = NULL,
  what = "names"
)

check_names(
  x,
  type = "named",
  subset.of = NULL,
  must.include = NULL,
  permutation.of = NULL,
  identical.to = NULL,
  disjunct.from = NULL,
  what = "names"
)

assertNames(
  x,
  type = "named",
  subset.of = NULL,
  must.include = NULL,
  permutation.of = NULL,
  identical.to = NULL,
  disjunct.from = NULL,
  what = "names",
  .var.name = vname(x),
  add = NULL
)

assert_names(
  x,
  type = "named",
  subset.of = NULL,
  must.include = NULL,
  permutation.of = NULL,
  identical.to = NULL,
  disjunct.from = NULL,
  what = "names",
  .var.name = vname(x),
  add = NULL
)

testNames(
  x,
  type = "named",
  subset.of = NULL,
  must.include = NULL,
  permutation.of = NULL,
  identical.to = NULL,
  disjunct.from = NULL,
  what = "names"
)

test_names(
  x,
  type = "named",
  subset.of = NULL,
  must.include = NULL,
  permutation.of = NULL,
  identical.to = NULL,
  disjunct.from = NULL,
  what = "names"
)

expect_names(
  x,
  type = "named",
  subset.of = NULL,
  must.include = NULL,
  permutation.of = NULL,
  identical.to = NULL,
  disjunct.from = NULL,
  what = "names",
  info = NULL,
  label = vname(x)
)
```

## Arguments

- x:

  \[`character` \|\| `NULL`\]  
  Names to check using rules defined via `type`.

- type:

  \[`character(1)`\]  
  Type of formal check(s) to perform on the names.

  unnamed:

  :   Checks `x` to be `NULL`.

  named:

  :   Checks `x` for regular names which excludes names to be `NA` or
      empty (`""`).

  unique:

  :   Performs checks like with “named” and additionally tests for
      non-duplicated names.

  strict:

  :   Performs checks like with “unique” and additionally fails for
      names with UTF-8 characters and names which do not comply to R's
      variable name restrictions. As regular expression, this is
      “^\[.\]\*\[a-zA-Z\]+\[a-zA-Z0-9.\_\]\*\$”.

  ids:

  :   Same as “strict”, but does not enforce uniqueness.

  Note that for zero-length `x`, all these name checks evaluate to
  `TRUE`.

- subset.of:

  \[`character`\]  
  Names provided in `x` must be subset of the set `subset.of`.

- must.include:

  \[`character`\]  
  Names provided in `x` must be a superset of the set `must.include`.

- permutation.of:

  \[`character`\]  
  Names provided in `x` must be a permutation of the set
  `permutation.of`. Duplicated names in `permutation.of` are stripped
  out and duplicated names in `x` thus lead to a failed check. Use this
  argument instead of `identical.to` if the order of the names is not
  relevant.

- identical.to:

  \[`character`\]  
  Names provided in `x` must be identical to the vector `identical.to`.
  Use this argument instead of `permutation.of` if the order of the
  names is relevant.

- disjunct.from:

  \[`character`\]  
  Names provided in `x` must may not be present in the vector
  `disjunct.from`.

- what:

  \[`character(1)`\]  
  Type of name vector to check, e.g. “names” (default), “colnames” or
  “rownames”.

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
functions `assertNames`/`assert_names` return `x` invisibly, whereas
`checkNames`/`check_names` and `testNames`/`test_names` return `TRUE`.
If the check is not successful, `assertNames`/`assert_names` throws an
error message, `testNames`/`test_names` returns `FALSE`, and
`checkNames`/`check_names` return a string with the error message. The
function `expect_names` always returns an
[`expectation`](https://testthat.r-lib.org/reference/expectation.html).

## See also

Other attributes:
[`checkClass()`](https://mllg.github.io/checkmate/reference/checkClass.md),
[`checkMultiClass()`](https://mllg.github.io/checkmate/reference/checkMultiClass.md),
[`checkNamed()`](https://mllg.github.io/checkmate/reference/checkNamed.md)

## Examples

``` r
x = 1:3
testNames(names(x), "unnamed")
#> [1] TRUE
names(x) = letters[1:3]
testNames(names(x), "unique")
#> [1] TRUE

cn = c("Species", "Sepal.Length", "Sepal.Width", "Petal.Length", "Petal.Width")
assertNames(names(iris), permutation.of = cn)
```
