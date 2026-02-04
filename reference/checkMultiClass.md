# Check the class membership of an argument

Check the class membership of an argument

## Usage

``` r
checkMultiClass(x, classes, null.ok = FALSE)

check_multi_class(x, classes, null.ok = FALSE)

assertMultiClass(x, classes, null.ok = FALSE, .var.name = vname(x), add = NULL)

assert_multi_class(
  x,
  classes,
  null.ok = FALSE,
  .var.name = vname(x),
  add = NULL
)

testMultiClass(x, classes, null.ok = FALSE)

test_multi_class(x, classes, null.ok = FALSE)

expect_multi_class(x, classes, null.ok = FALSE, info = NULL, label = vname(x))
```

## Arguments

- x:

  \[`any`\]  
  Object to check.

- classes:

  \[`character`\]  
  Class names to check for inheritance with
  [`inherits`](https://rdrr.io/r/base/class.html). `x` must inherit from
  any of the specified classes.

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
functions `assertMultiClass`/`assert_multi_class` return `x` invisibly,
whereas `checkMultiClass`/`check_multi_class` and
`testMultiClass`/`test_multi_class` return `TRUE`. If the check is not
successful, `assertMultiClass`/`assert_multi_class` throws an error
message, `testMultiClass`/`test_multi_class` returns `FALSE`, and
`checkMultiClass`/`check_multi_class` return a string with the error
message. The function `expect_multi_class` always returns an
[`expectation`](https://testthat.r-lib.org/reference/expectation.html).

## See also

Other attributes:
[`checkClass()`](https://mllg.github.io/checkmate/reference/checkClass.md),
[`checkNamed()`](https://mllg.github.io/checkmate/reference/checkNamed.md),
[`checkNames()`](https://mllg.github.io/checkmate/reference/checkNames.md)

Other classes:
[`checkClass()`](https://mllg.github.io/checkmate/reference/checkClass.md),
[`checkR6()`](https://mllg.github.io/checkmate/reference/checkR6.md)

## Examples

``` r
x = 1
class(x) = "bar"
checkMultiClass(x, c("foo", "bar"))
#> [1] TRUE
checkMultiClass(x, c("foo", "foobar"))
#> [1] "Must inherit from class 'foo'/'foobar', but has class 'bar'"
```
