# Collect multiple assertions

The function `makeAssertCollection()` returns a simple stack-like
closure you can pass to all functions of the `assert*`-family. All
messages get collected and can be reported with `reportAssertions()`.
Alternatively, you can easily write your own report function or
customize the the output of the report function to a certain degree. See
the example on how to push custom messages or retrieve all stored
messages.

## Usage

``` r
makeAssertCollection()

reportAssertions(collection)
```

## Arguments

- collection:

  \[`AssertCollection`\]  
  Object of type “AssertCollection” (constructed via
  `makeAssertCollection`).

## Value

`makeAssertCollection()` returns an object of class “AssertCollection”
and `reportCollection` returns invisibly `TRUE` if no error is thrown
(i.e., no message was collected).

## Examples

``` r
x = "a"
coll = makeAssertCollection()

print(coll$isEmpty())
#> [1] TRUE
assertNumeric(x, add = coll)
coll$isEmpty()
#> [1] FALSE
coll$push("Custom error message")
coll$getMessages()
#> [1] "Variable 'x': Must be of type 'numeric', not 'character'."
#> [2] "Custom error message"                                     
if (FALSE) { # \dontrun{
  reportAssertions(coll)
} # }
```
