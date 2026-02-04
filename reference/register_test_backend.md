# Select Backend for Unit Tests

Allows to explicitly select a backend for the unit tests. Currently
supported are `"testthat"` and `"tinytest"`. The respective package must
be installed and are loaded (but not attached).

If this function is not explicitly called, defaults to `"testthat"`
unless the `"tinytest"`'s namespace is loaded.

## Usage

``` r
register_test_backend(name)
```

## Arguments

- name:

  \[`character(1)`\]  
  `"testthat"` or `"tinytest"`.

## Value

`NULL` (invisibly).
