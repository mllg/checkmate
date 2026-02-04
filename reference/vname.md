# Lookup a variable name

Tries to heuristically determine the variable name of `x` in the parent
frame with a combination of
[`deparse`](https://rdrr.io/r/base/deparse.html) and
[`substitute`](https://rdrr.io/r/base/substitute.html). Used for
checkmate's error messages.

## Usage

``` r
vname(x)
```

## Arguments

- x:

  \[`any`\]  
  Object.

## Value

\[`character(1)`\] Variable name.
