# Partial Argument Matching

This is an extensions to
[`match.arg`](https://rdrr.io/r/base/match.arg.html) with support for
[`AssertCollection`](https://mllg.github.io/checkmate/reference/AssertCollection.md).
The behavior is very similar to
[`match.arg`](https://rdrr.io/r/base/match.arg.html), except that `NULL`
is not a valid value for `x`.

## Usage

``` r
matchArg(x, choices, several.ok = FALSE, .var.name = vname(x), add = NULL)
```

## Arguments

- x:

  \[`character`\]  
  User provided argument to match.

- choices:

  \[`character`\]  
  Candidates to match `x` with.

- several.ok:

  \[`logical(1)`\]  
  If `TRUE`, multiple matches are allowed, cf.
  [`match.arg`](https://rdrr.io/r/base/match.arg.html).

- .var.name:

  \[`character(1)`\]  
  Name of the checked object to print in error messages. Defaults to the
  heuristic implemented in
  [`vname`](https://mllg.github.io/checkmate/reference/vname.md).

- add:

  \[`AssertCollection`\]  
  Collection to store assertions. See
  [`AssertCollection`](https://mllg.github.io/checkmate/reference/AssertCollection.md).

## Value

Subset of `choices`.

## Examples

``` r
matchArg("k", choices = c("kendall", "pearson"))
#> [1] "kendall"
```
