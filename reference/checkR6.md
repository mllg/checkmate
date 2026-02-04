# Check if an argument is an R6 class

Check if an argument is an R6 class

## Usage

``` r
checkR6(
  x,
  classes = NULL,
  ordered = FALSE,
  cloneable = NULL,
  public = NULL,
  private = NULL,
  null.ok = FALSE
)

check_r6(
  x,
  classes = NULL,
  ordered = FALSE,
  cloneable = NULL,
  public = NULL,
  private = NULL,
  null.ok = FALSE
)

assertR6(
  x,
  classes = NULL,
  ordered = FALSE,
  cloneable = NULL,
  public = NULL,
  private = NULL,
  null.ok = FALSE,
  .var.name = vname(x),
  add = NULL
)

assert_r6(
  x,
  classes = NULL,
  ordered = FALSE,
  cloneable = NULL,
  public = NULL,
  private = NULL,
  null.ok = FALSE,
  .var.name = vname(x),
  add = NULL
)

testR6(
  x,
  classes = NULL,
  ordered = FALSE,
  cloneable = NULL,
  public = NULL,
  private = NULL,
  null.ok = FALSE
)

test_r6(
  x,
  classes = NULL,
  ordered = FALSE,
  cloneable = NULL,
  public = NULL,
  private = NULL,
  null.ok = FALSE
)

expect_r6(
  x,
  classes = NULL,
  ordered = FALSE,
  cloneable = NULL,
  public = NULL,
  private = NULL,
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

- cloneable:

  \[`logical(1)`\]  
  If `TRUE`, check that `x` has a `clone` method. If `FALSE`, ensure
  that `x` is not cloneable.

- public:

  \[`character`\]  
  Names of expected public slots. This includes active bindings.

- private:

  \[`character`\]  
  Names of expected private slots.

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

Other classes:
[`checkClass()`](https://mllg.github.io/checkmate/reference/checkClass.md),
[`checkMultiClass()`](https://mllg.github.io/checkmate/reference/checkMultiClass.md)

## Examples

``` r
library(R6)
generator = R6Class("Bar",
  public = list(a = 5),
  private = list(b = 42),
  active = list(c = function() 99)
)
x = generator$new()
checkR6(x, "Bar", cloneable = TRUE, public = "a")
#> [1] TRUE
```
