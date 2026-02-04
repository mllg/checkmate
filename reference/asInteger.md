# Convert an argument to an integer

`asInteger` is intended to be used for vectors while `asInt` is a
specialization for scalar integers and `asCount` for scalar non-negative
integers. Convertible are (a) atomic vectors with all elements `NA` and
(b) double vectors with all elements being within `tol` range of an
integer.

Note that these functions may be deprecated in the future. Instead, it
is advised to use
[`assertCount`](https://mllg.github.io/checkmate/reference/checkCount.md),
[`assertInt`](https://mllg.github.io/checkmate/reference/checkInt.md) or
[`assertIntegerish`](https://mllg.github.io/checkmate/reference/checkIntegerish.md)
with argument `coerce` set to `TRUE` instead.

## Usage

``` r
asInteger(
  x,
  tol = sqrt(.Machine$double.eps),
  lower = -Inf,
  upper = Inf,
  any.missing = TRUE,
  all.missing = TRUE,
  len = NULL,
  min.len = NULL,
  max.len = NULL,
  unique = FALSE,
  sorted = FALSE,
  names = NULL,
  .var.name = vname(x)
)

asCount(
  x,
  na.ok = FALSE,
  positive = FALSE,
  tol = sqrt(.Machine$double.eps),
  .var.name = vname(x)
)

asInt(
  x,
  na.ok = FALSE,
  lower = -Inf,
  upper = Inf,
  tol = sqrt(.Machine$double.eps),
  .var.name = vname(x)
)
```

## Arguments

- x:

  \[`any`\]  
  Object to convert.

- tol:

  \[`double(1)`\]  
  Numerical tolerance used to check whether a double or complex can be
  converted. Default is `sqrt(.Machine$double.eps)`.

- lower:

  \[`numeric(1)`\]  
  Lower value all elements of `x` must be greater than or equal to.

- upper:

  \[`numeric(1)`\]  
  Upper value all elements of `x` must be lower than or equal to.

- any.missing:

  \[`logical(1)`\]  
  Are vectors with missing values allowed? Default is `TRUE`.

- all.missing:

  \[`logical(1)`\]  
  Are vectors with no non-missing values allowed? Default is `TRUE`.
  Note that empty vectors do not have non-missing values.

- len:

  \[`integer(1)`\]  
  Exact expected length of `x`.

- min.len:

  \[`integer(1)`\]  
  Minimal length of `x`.

- max.len:

  \[`integer(1)`\]  
  Maximal length of `x`.

- unique:

  \[`logical(1)`\]  
  Must all values be unique? Default is `FALSE`.

- sorted:

  \[`logical(1)`\]  
  Elements must be sorted in ascending order. Missing values are
  ignored.

- names:

  \[`character(1)`\]  
  Check for names. See
  [`checkNamed`](https://mllg.github.io/checkmate/reference/checkNamed.md)
  for possible values. Default is “any” which performs no check at all.
  Note that you can use
  [`checkSubset`](https://mllg.github.io/checkmate/reference/checkSubset.md)
  to check for a specific set of names.

- .var.name:

  \[`character(1)`\]  
  Name of the checked object to print in error messages. Defaults to the
  heuristic implemented in
  [`vname`](https://mllg.github.io/checkmate/reference/vname.md).

- na.ok:

  \[`logical(1)`\]  
  Are missing values allowed? Default is `FALSE`.

- positive:

  \[`logical(1)`\]  
  Must `x` be positive (\>= 1)? Default is `FALSE`.

## Value

Converted `x`.

## Details

This function does not distinguish between `NA`, `NA_integer_`,
`NA_real_`, `NA_complex_` `NA_character_` and `NaN`.

## Examples

``` r
asInteger(c(1, 2, 3))
#> [1] 1 2 3
asCount(1)
#> [1] 1
asInt(1)
#> [1] 1
```
