# Check the class membership of an argument

Check the class membership of an argument

## Usage

``` r
checkClass(x, classes, ordered = FALSE, null.ok = FALSE)

check_class(x, classes, ordered = FALSE, null.ok = FALSE)

assertClass(
  x,
  classes,
  ordered = FALSE,
  null.ok = FALSE,
  .var.name = vname(x),
  add = NULL
)

assert_class(
  x,
  classes,
  ordered = FALSE,
  null.ok = FALSE,
  .var.name = vname(x),
  add = NULL
)

testClass(x, classes, ordered = FALSE, null.ok = FALSE)

test_class(x, classes, ordered = FALSE, null.ok = FALSE)

expect_class(
  x,
  classes,
  ordered = FALSE,
  null.ok = FALSE,
  info = NULL,
  label = vname(x)
)
```

## Arguments

- x:

  \[`any`\]  
  Object to check.

- classes:

  \[`character`\]  
  Class names to check for inheritance with
  [`inherits`](https://rdrr.io/r/base/class.html). `x` must inherit from
  all specified classes.

- ordered:

  \[`logical(1)`\]  
  Expect `x` to be specialized in provided order. Default is `FALSE`.

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
functions `assertClass`/`assert_class` return `x` invisibly, whereas
`checkClass`/`check_class` and `testClass`/`test_class` return `TRUE`.
If the check is not successful, `assertClass`/`assert_class` throws an
error message, `testClass`/`test_class` returns `FALSE`, and
`checkClass`/`check_class` return a string with the error message. The
function `expect_class` always returns an
[`expectation`](https://testthat.r-lib.org/reference/expectation.html).

## See also

Other attributes:
[`checkMultiClass()`](https://mllg.github.io/checkmate/reference/checkMultiClass.md),
[`checkNamed()`](https://mllg.github.io/checkmate/reference/checkNamed.md),
[`checkNames()`](https://mllg.github.io/checkmate/reference/checkNames.md)

Other classes:
[`checkMultiClass()`](https://mllg.github.io/checkmate/reference/checkMultiClass.md),
[`checkR6()`](https://mllg.github.io/checkmate/reference/checkR6.md)

## Examples

``` r
# Create an object with classes "foo" and "bar"
x = 1
class(x) = c("foo", "bar")

# is x of class "foo"?
testClass(x, "foo")
#> [1] TRUE

# is x of class "foo" and "bar"?
testClass(x, c("foo", "bar"))
#> [1] TRUE

# is x of class "foo" or "bar"?
if (FALSE) { # \dontrun{
assert(
  checkClass(x, "foo"),
  checkClass(x, "bar")
)
} # }
# is x most specialized as "bar"?
testClass(x, "bar", ordered = TRUE)
#> [1] FALSE
```
