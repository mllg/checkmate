# Get the index of the first/last TRUE

A quick C implementation for “which.first” (`head(which(x), 1)`) and
“which.last” (`tail(which(x), 1)`).

## Usage

``` r
wf(x, use.names = TRUE)

wl(x, use.names = TRUE)
```

## Arguments

- x:

  \[`logical`\]  
  Logical vector.

- use.names:

  \[`logical(1)`\]  
  If `TRUE` and `x` is named, the result is also named.

## Value

\[`integer(1)` \| `integer(0)`\]. Returns the index of the first/last
`TRUE` value in `x` or an empty integer vector if none is found. NAs are
ignored.

## Examples

``` r
wf(c(FALSE, TRUE))
#> [1] 2
wl(c(FALSE, FALSE))
#> integer(0)
wf(NA)
#> integer(0)
```
