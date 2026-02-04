# Check for existence and access rights of directories

Check for existence and access rights of directories

## Usage

``` r
checkDirectoryExists(x, access = "")

check_directory_exists(x, access = "")

assertDirectoryExists(x, access = "", .var.name = vname(x), add = NULL)

assert_directory_exists(x, access = "", .var.name = vname(x), add = NULL)

testDirectoryExists(x, access = "")

test_directory_exists(x, access = "")

expect_directory_exists(x, access = "", info = NULL, label = vname(x))

checkDirectory(x, access = "")

assertDirectory(x, access = "", .var.name = vname(x), add = NULL)

assert_directory(x, access = "", .var.name = vname(x), add = NULL)

testDirectory(x, access = "")

test_directory(x, access = "")

expect_directory(x, access = "", info = NULL, label = vname(x))
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
functions `assertDirectoryExists`/`assert_directory_exists` return `x`
invisibly, whereas `checkDirectoryExists`/`check_directory_exists` and
`testDirectoryExists`/`test_directory_exists` return `TRUE`. If the
check is not successful,
`assertDirectoryExists`/`assert_directory_exists` throws an error
message, `testDirectoryExists`/`test_directory_exists` returns `FALSE`,
and `checkDirectoryExists`/`check_directory_exists` return a string with
the error message. The function `expect_directory_exists` always returns
an
[`expectation`](https://testthat.r-lib.org/reference/expectation.html).

## Note

The functions without the suffix “exists” are deprecated and will be
removed from the package in a future version due to name clashes.

## See also

Other filesystem:
[`checkAccess()`](https://mllg.github.io/checkmate/reference/checkAccess.md),
[`checkFileExists()`](https://mllg.github.io/checkmate/reference/checkFileExists.md),
[`checkPathForOutput()`](https://mllg.github.io/checkmate/reference/checkPathForOutput.md)

## Examples

``` r
# Is R's home directory readable?
testDirectory(R.home(), "r")
#> [1] TRUE

# Is R's home directory readable and writable?
testDirectory(R.home(), "rw")
#> [1] FALSE
```
