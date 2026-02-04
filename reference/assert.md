# Combine multiple checks into one assertion

You can call this function with an arbitrary number of of `check*`
functions, i.e. functions provided by this package or your own functions
which return `TRUE` on success and the error message as `character(1)`
otherwise. The resulting assertion is successful, if `combine` is “or”
(default) and at least one check evaluates to `TRUE` or `combine` is
“and” and all checks evaluate to `TRUE`. Otherwise, `assert` throws an
informative error message.

## Usage

``` r
assert(..., combine = "or", .var.name = NULL, add = NULL)
```

## Arguments

- ...:

  \[`any`\]  
  List of calls to check functions.

- combine:

  \[`character(1)`\]  
  “or” or “and” to combine the check functions with an OR or AND,
  respectively.

- .var.name:

  \[`character(1)`\]  
  Name of the checked object to print in assertions. Defaults to the
  heuristic implemented in
  [`vname`](https://mllg.github.io/checkmate/reference/vname.md).

- add:

  \[`AssertCollection`\]  
  Collection to store assertion messages. See
  [`AssertCollection`](https://mllg.github.io/checkmate/reference/AssertCollection.md).

## Value

Throws an error (or pushes the error message to an
[`AssertCollection`](https://mllg.github.io/checkmate/reference/AssertCollection.md)
if `add` is not `NULL`) if the checks fail and invisibly returns `TRUE`
otherwise.

## Examples

``` r
x = 1:10
assert(checkNull(x), checkInteger(x, any.missing = FALSE))
collection <- makeAssertCollection()
assert(checkChoice(x, c("a", "b")), checkDataFrame(x), add = collection)
collection$getMessages()
#> [1] "Variable 'x': One of the following must apply:\n * checkChoice(x): Must be element of set {'a','b'}, but is not atomic\n * scalar\n * checkDataFrame(x): Must be of type 'data.frame', not 'integer'."
```
