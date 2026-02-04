# Coalesce operator

Returns the left hand side if not missing nor `NULL`, and the right hand
side otherwise.

## Usage

``` r
lhs %??% rhs
```

## Arguments

- lhs:

  \[`any`\]  
  Left hand side of the operator. Is returned if not missing or `NULL`.

- rhs:

  \[`any`\]  
  Right hand side of the operator. Is returned if `lhs` is missing or
  `NULL`.

## Value

Either `lhs` or `rhs`.

## Examples

``` r
print(NULL %??% 1 %??% 2)
#> [1] 1
print(names(iris) %??% letters[seq_len(ncol(iris))])
#> [1] "Sepal.Length" "Sepal.Width"  "Petal.Length" "Petal.Width"  "Species"     
```
