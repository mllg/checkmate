# Check if an object contains missing values

`anyMissing` checks for the presence of at least one missing value,
`allMissing` checks for the presence of at least one non-missing value.
Supported are atomic types (see
[`is.atomic`](https://rdrr.io/r/base/is.recursive.html)), lists and data
frames. Missingness is defined as `NA` or `NaN` for atomic types and
data frame columns, `NULL` is defined as missing for lists.  
`allMissing` applied to a `data.frame` returns `TRUE` if at least one
column has only non-missing values. If you want to perform the less
frequent check that there is at least a single non-missing observation
present in the `data.frame`, use `all(sapply(df, allMissing))` instead.

## Usage

``` r
allMissing(x)

anyMissing(x)
```

## Arguments

- x:

  \[`any`\]  
  Object to check.

## Value

\[`logical(1)`\] Returns `TRUE` if any (`anyMissing`) or all
(`allMissing`) elements of `x` are missing (see details), `FALSE`
otherwise.

## Examples

``` r
allMissing(1:2)
#> [1] FALSE
allMissing(c(1, NA))
#> [1] FALSE
allMissing(c(NA, NA))
#> [1] TRUE
x = data.frame(a = 1:2, b = NA)
# Note how allMissing combines the results for data frames:
allMissing(x)
#> [1] TRUE
all(sapply(x, allMissing))
#> [1] FALSE
anyMissing(c(1, 1))
#> [1] FALSE
anyMissing(c(1, NA))
#> [1] TRUE
anyMissing(list(1, NULL))
#> [1] TRUE

x = iris
x[, "Species"] = NA
anyMissing(x)
#> [1] TRUE
allMissing(x)
#> [1] TRUE
```
