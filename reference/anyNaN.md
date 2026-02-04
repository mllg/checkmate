# Check if an object contains NaN values

Supported are atomic types (see
[`is.atomic`](https://rdrr.io/r/base/is.recursive.html)), lists and data
frames.

## Usage

``` r
anyNaN(x)
```

## Arguments

- x:

  \[`any`\]  
  Object to check.

## Value

\[`logical(1)`\] Returns `TRUE` if any element is `NaN`.

## Examples

``` r
anyNaN(1:10)
#> [1] FALSE
anyNaN(c(1:10, NaN))
#> [1] TRUE
iris[3, 3] = NaN
anyNaN(iris)
#> [1] TRUE
```
