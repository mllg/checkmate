# Quick argument checks on (builtin) R types

The provided functions parse rules which allow to express some of the
most frequent argument checks by typing just a few letters.

## Usage

``` r
qassert(x, rules, .var.name = vname(x))

qtest(x, rules)

qexpect(x, rules, info = NULL, label = vname(x))
```

## Arguments

- x:

  \[`any`\]  
  Object the check.

- rules:

  \[`character`\]  
  Set of rules. See details.

- .var.name:

  \[`character(1)`\]  
  Name of the checked object to print in error messages. Defaults to the
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

`qassert` throws an `R` exception if object `x` does not comply to at
least one of the `rules` and returns the tested object invisibly
otherwise. `qtest` behaves the same way but returns `FALSE` if none of
the `rules` comply. `qexpect` is intended to be inside the unit test
framework
[`testthat`](https://testthat.r-lib.org/reference/testthat-package.html)
and returns an
[`expectation`](https://testthat.r-lib.org/reference/expectation.html).

## Details

The rule is specified in up to three parts.

1.  Class and missingness check. The first letter is an abbreviation for
    the class. If it is provided uppercase, missing values are
    prohibited. Supported abbreviations:

    |        |                                                                                                                                      |
    |--------|--------------------------------------------------------------------------------------------------------------------------------------|
    | `[bB]` | Bool / logical.                                                                                                                      |
    | `[iI]` | Integer.                                                                                                                             |
    | `[xX]` | Integerish (numeric convertible to integer, see [`checkIntegerish`](https://mllg.github.io/checkmate/reference/checkIntegerish.md)). |
    | `[rR]` | Real / double.                                                                                                                       |
    | `[cC]` | Complex.                                                                                                                             |
    | `[nN]` | Numeric (integer or double).                                                                                                         |
    | `[sS]` | String / character.                                                                                                                  |
    | `[fF]` | Factor                                                                                                                               |
    | `[aA]` | Atomic.                                                                                                                              |
    | `[vV]` | Atomic vector (see [`checkAtomicVector`](https://mllg.github.io/checkmate/reference/checkAtomicVector.md)).                          |
    | `[lL]` | List. Missingness is defined as `NULL` element.                                                                                      |
    | `[mM]` | Matrix.                                                                                                                              |
    | `[dD]` | Data.frame. Missingness is checked recursively on columns.                                                                           |
    | `[pP]` | POSIXct date.                                                                                                                        |
    | `[e]`  | Environment.                                                                                                                         |
    | `[0]`  | `NULL`.                                                                                                                              |
    | `[*]`  | placeholder to allow any type.                                                                                                       |

    Note that the check for missingness does not distinguish between
    `NaN` and `NA`. Infinite values are not treated as missing, but can
    be caught using boundary checks (part 3).

2.  Length definition. This can be one of

    |          |                                    |
    |----------|------------------------------------|
    | `[*]`    | any length,                        |
    | `[?]`    | length of zero or one,             |
    | `[+]`    | length of at least one, or         |
    | `[0-9]+` | exact length specified as integer. |

    Preceding the exact length with one of the comparison operators
    `=`/`==`, `<`, `<=`, `>=` or `>` is also supported.

3.  Range check as two numbers separated by a comma, enclosed by square
    brackets (endpoint included) or parentheses (endpoint excluded). For
    example, “\[0, 3)” results in `all(x >= 0 & x < 3)`. The lower and
    upper bound may be omitted which is the equivalent of a negative or
    positive infinite bound, respectively. By definition `[0,]` contains
    `Inf`, while `[0,)` does not. The same holds for the left (lower)
    boundary and `-Inf`. E.g., the rule “N1()” checks for a single
    finite numeric which is not NA, while “N1\[)” allows `-Inf`.

## Note

The functions are inspired by the blog post of Bogumił Kamiński:
[http://rsnippets.blogspot.de/2013/06/testing-function-agruments-in-gnu-r.html](http://rsnippets.blogspot.de/2013/06/testing-function-agruments-in-gnu-r.md).
The implementation is mostly written in C to minimize the overhead.

## See also

[`qtestr`](https://mllg.github.io/checkmate/reference/qassertr.md) and
[`qassertr`](https://mllg.github.io/checkmate/reference/qassertr.md) for
efficient checks of list elements and data frame columns.

## Examples

``` r
# logical of length 1
qtest(NA, "b1")
#> [1] TRUE

# logical of length 1, NA not allowed
qtest(NA, "B1")
#> [1] FALSE

# logical of length 0 or 1, NA not allowed
qtest(TRUE, "B?")
#> [1] TRUE

# numeric with length > 0
qtest(runif(10), "n+")
#> [1] TRUE

# integer with length > 0, NAs not allowed, all integers >= 0 and < Inf
qtest(1:3, "I+[0,)")
#> [1] TRUE

# either an emtpy list or a character vector with <=5 elements
qtest(1, c("l0", "s<=5"))
#> [1] FALSE

# data frame with at least one column and no missing value in any column
qtest(iris, "D+")
#> [1] TRUE
```
