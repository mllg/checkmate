# Check if an object contains infinite values

Supported are atomic types (see
[`is.atomic`](https://rdrr.io/r/base/is.recursive.html)), lists and data
frames.

## Usage

``` r
anyInfinite(x)
```

## Arguments

- x:

  \[`any`\]  
  Object to check.

## Value

\[`logical(1)`\] Returns `TRUE` if any element is `-Inf` or `Inf`.

## Examples

``` r
anyInfinite(1:10)
#> [1] FALSE
anyInfinite(c(1:10, Inf))
#> [1] TRUE
iris[3, 3] = Inf
anyInfinite(iris)
#> [1] TRUE
```
