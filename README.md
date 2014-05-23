# checkmate

Fast and versatile argument checks for R.

* Travis CI: [![Build Status](https://travis-ci.org/mllg/checkmate.svg)](https://travis-ci.org/mllg/checkmate)


Ever used an R function that produced a not very helpful message, just to discover minutes later that you simply passed a wrong argument? 
Blaming the laziness of the package author for not doing such a standard check (in a weakly typed language such as R) is at least partially unfair, as R makes theses types of checks cumbersome and annoying. Well, that's how it was in the past. Enter checkmate. Virtaually every standard type of user error when passing arguments into function can be caiught with a simple, readable line which produces an informative error message in case. A substantial part of the package was written in C to minimize any worries about execution time overhead. 

Here is an overview how of the most useful functions for arg checking:

### Scalars:

* checkCount
* checkFlag


### Vectors and factors:

* checkNumeric
* checkInteger
* checkIntegerish
* checkCharacter
* checkFactor

What you can check: Length, upper and lower bounds, NAs. 

### List:

* checkList

What you can check: length, element type, whether its named.

### File IO:

* checkDir
* checkFile

What you can check: Path exists, is accessible, is of write tyoe (dir or file).

