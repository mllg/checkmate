# Check the operating system

Check the operating system

## Usage

``` r
checkOS(os)

check_os(os)

assertOS(os, add = NULL, .var.name = NULL)

assert_os(os, add = NULL, .var.name = NULL)

testOS(os)

test_os(os)

expect_os(os, info = NULL, label = NULL)
```

## Arguments

- os:

  \[`character`\]  
  Check the operating system to be in a set with possible elements
  “windows”, “mac”, “linux” and “solaris”.

- add:

  \[`AssertCollection`\]  
  Collection to store assertion messages. See
  [`AssertCollection`](https://mllg.github.io/checkmate/reference/AssertCollection.md).

- .var.name:

  \[`character(1)`\]  
  Name of the checked object to print in assertions. Defaults to the
  heuristic implemented in
  [`vname`](https://mllg.github.io/checkmate/reference/vname.md).

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
functions `assertOS`/`assert_os` return `x` invisibly, whereas
`checkOS`/`check_os` and `testOS`/`test_os` return `TRUE`. If the check
is not successful, `assertOS`/`assert_os` throws an error message,
`testOS`/`test_os` returns `FALSE`, and `checkOS`/`check_os` return a
string with the error message. The function `expect_os` always returns
an
[`expectation`](https://testthat.r-lib.org/reference/expectation.html).

## Examples

``` r
testOS("linux")
#> [1] TRUE
```
