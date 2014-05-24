# checkmate

Fast and versatile argument checks for R.

* Travis CI: [![Build Status](https://travis-ci.org/mllg/checkmate.svg)](https://travis-ci.org/mllg/checkmate)


Ever used an R function that produced a not-very-helpful error message,
just to discover after minutes of debugging that you simply passed a wrong argument?

Blaming the laziness of the package author for not doing such standard checks
(in a weakly typed language such as R) is at least partially unfair, as R makes theses types of checks
cumbersome and annoying. Well, that's how it was in the past.

Enter checkmate.

Virtually **every standard type of user error** when passing arguments into function can be
caught with a simple, readable line which produces an **informative error message** in case.
A substantial part of the package was written in C to **minimize any worries about execution time overhead**.

Here is an overview of the most useful functions for argument checking:

### Scalars / Single Objects:

* checkFlag
* checkNumber
* checkCount
* checkString
* checkClass

What can be checked: Simple, non-NA scalars and objects of a specific class.

### Choices and Subsets

* checkChoice
* checkSubset

What can be checked: Choices like "A", "B" or "C" or a subet of those.

### Vectors and factors:

* checkLogical
* checkNumeric
* checkInteger
* checkIntegerish
* checkComplex
* checkCharacter
* checkFactor

What can be checked: Length, upper and lower bounds, NAs.

### Matrices and Data Frame:

* checkMatrix
* checkDataFrame

What can be checked: Number of rows, cols, NAs, names.

### List / Environments:

* checkList
* checkEnvironment

What can be checked: length, element type, names.

### File IO:

* checkDir
* checkFile

What can be checked: Path exists, is accessible.

