# Check existence and access rights of files

Check existence and access rights of files

## Usage

``` r
checkFileExists(x, access = "", extension = NULL)

check_file_exists(x, access = "", extension = NULL)

assertFileExists(
  x,
  access = "",
  extension = NULL,
  .var.name = vname(x),
  add = NULL
)

assert_file_exists(
  x,
  access = "",
  extension = NULL,
  .var.name = vname(x),
  add = NULL
)

testFileExists(x, access = "", extension = NULL)

test_file_exists(x, access = "", extension = NULL)

expect_file_exists(
  x,
  access = "",
  extension = NULL,
  info = NULL,
  label = vname(x)
)

checkFile(x, access = "", extension = NULL)

assertFile(x, access = "", extension = NULL, .var.name = vname(x), add = NULL)

assert_file(x, access = "", extension = NULL, .var.name = vname(x), add = NULL)

testFile(x, access = "", extension = NULL)

expect_file(x, access = "", extension = NULL, info = NULL, label = vname(x))
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

- extension:

  \[`character`\]  
  Vector of allowed file extensions, matched case insensitive.

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
functions `assertFileExists`/`assert_file_exists` return `x` invisibly,
whereas `checkFileExists`/`check_file_exists` and
`testFileExists`/`test_file_exists` return `TRUE`. If the check is not
successful, `assertFileExists`/`assert_file_exists` throws an error
message, `testFileExists`/`test_file_exists` returns `FALSE`, and
`checkFileExists`/`check_file_exists` return a string with the error
message. The function `expect_file_exists` always returns an
[`expectation`](https://testthat.r-lib.org/reference/expectation.html).

## Note

The functions without the suffix “exists” are deprecated and will be
removed from the package in a future version due to name clashes.
`test_file` has been unexported already.

## See also

Other filesystem:
[`checkAccess()`](https://mllg.github.io/checkmate/reference/checkAccess.md),
[`checkDirectoryExists()`](https://mllg.github.io/checkmate/reference/checkDirectoryExists.md),
[`checkPathForOutput()`](https://mllg.github.io/checkmate/reference/checkPathForOutput.md)

## Examples

``` r
# Check if R's COPYING file is readable
testFileExists(file.path(R.home(), "COPYING"), access = "r")
#> [1] TRUE

# Check if R's COPYING file is readable and writable
testFileExists(file.path(R.home(), "COPYING"), access = "rw")
#> [1] FALSE
```
