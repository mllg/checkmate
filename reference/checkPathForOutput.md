# Check if a path is suited for creating an output file

Check if a file path can be used safely to create a file and write to
it.

This is checked:

- Does `dirname(x)` exist?

- Does no file under path `x` exist?

- Is `dirname(x)` writable?

Paths are relative to the current working directory.

## Usage

``` r
checkPathForOutput(x, overwrite = FALSE, extension = NULL)

check_path_for_output(x, overwrite = FALSE, extension = NULL)

assertPathForOutput(
  x,
  overwrite = FALSE,
  extension = NULL,
  .var.name = vname(x),
  add = NULL
)

assert_path_for_output(
  x,
  overwrite = FALSE,
  extension = NULL,
  .var.name = vname(x),
  add = NULL
)

testPathForOutput(x, overwrite = FALSE, extension = NULL)

test_path_for_output(x, overwrite = FALSE, extension = NULL)

expect_path_for_output(
  x,
  overwrite = FALSE,
  extension = NULL,
  info = NULL,
  label = vname(x)
)
```

## Arguments

- x:

  \[`any`\]  
  Object to check.

- overwrite:

  \[`logical(1)`\]  
  If `TRUE`, an existing file in place is allowed if it it is both
  readable and writable. Default is `FALSE`.

- extension:

  \[`character(1)`\]  
  Extension of the file, e.g. “txt” or “tar.gz”.

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
functions `assertPathForOutput`/`assert_path_for_output` return `x`
invisibly, whereas `checkPathForOutput`/`check_path_for_output` and
`testPathForOutput`/`test_path_for_output` return `TRUE`. If the check
is not successful, `assertPathForOutput`/`assert_path_for_output` throws
an error message, `testPathForOutput`/`test_path_for_output` returns
`FALSE`, and `checkPathForOutput`/`check_path_for_output` return a
string with the error message. The function `expect_path_for_output`
always returns an
[`expectation`](https://testthat.r-lib.org/reference/expectation.html).

## See also

Other filesystem:
[`checkAccess()`](https://mllg.github.io/checkmate/reference/checkAccess.md),
[`checkDirectoryExists()`](https://mllg.github.io/checkmate/reference/checkDirectoryExists.md),
[`checkFileExists()`](https://mllg.github.io/checkmate/reference/checkFileExists.md)

## Examples

``` r
# Can we create a file in the tempdir?
testPathForOutput(file.path(tempdir(), "process.log"))
#> [1] TRUE
```
