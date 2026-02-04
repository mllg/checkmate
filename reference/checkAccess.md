# Check file system access rights

Check file system access rights

## Usage

``` r
checkAccess(x, access = "")

check_access(x, access = "")

assertAccess(x, access = "", .var.name = vname(x), add = NULL)

assert_access(x, access = "", .var.name = vname(x), add = NULL)

testAccess(x, access = "")

test_access(x, access = "")

expect_access(x, access = "", info = NULL, label = vname(x))
```

## Arguments

- x:

  \[`any`\]  
  Object to check.

- access:

  \[`character(1)`\]  
  Single string containing possible characters ‘r’, ‘w’ and ‘x’ to force
  a check for read, write or execute access rights, respectively. Write
  and executable rights are not checked on Windows.

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
functions `assertAccess`/`assert_access` return `x` invisibly, whereas
`checkAccess`/`check_access` and `testAccess`/`test_access` return
`TRUE`. If the check is not successful, `assertAccess`/`assert_access`
throws an error message, `testAccess`/`test_access` returns `FALSE`, and
`checkAccess`/`check_access` return a string with the error message. The
function `expect_access` always returns an
[`expectation`](https://testthat.r-lib.org/reference/expectation.html).

## See also

Other filesystem:
[`checkDirectoryExists()`](https://mllg.github.io/checkmate/reference/checkDirectoryExists.md),
[`checkFileExists()`](https://mllg.github.io/checkmate/reference/checkFileExists.md),
[`checkPathForOutput()`](https://mllg.github.io/checkmate/reference/checkPathForOutput.md)

## Examples

``` r
# Is R's home directory readable?
testAccess(R.home(), "r")
#> [1] TRUE

# Is R's home directory writeable?
testAccess(R.home(), "w")
#> [1] FALSE
```
