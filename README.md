# checkmate

[![CRAN](https://img.shields.io/badge/cran-1.5.2-yellow.svg)](http://cran.r-project.org/web/packages/checkmate/)
[![Build Status](https://travis-ci.org/mllg/checkmate.svg)](https://travis-ci.org/mllg/checkmate)
[![Build status](https://ci.appveyor.com/api/projects/status/y4ayps61hjd3375o/branch/master?svg=true)](https://ci.appveyor.com/project/mllg/checkmate/branch/master)
[![Coverage Status](https://img.shields.io/coveralls/mllg/checkmate.svg)](https://coveralls.io/r/mllg/checkmate?branch=master)

Fast and versatile argument checks for R.

Ever used an R function that produced a not-very-helpful error message,
just to discover after minutes of debugging that you simply passed a wrong argument?

Blaming the laziness of the package author for not doing such standard checks
(in a dynamically typed language such as R) is at least partially unfair, as R makes theses types of checks
cumbersome and annoying. Well, that's how it was in the past.

Enter checkmate.

Virtually **every standard type of user error** when passing arguments into function can be
caught with a simple, readable line which produces an **informative error message** in case.
A substantial part of the package was written in C to **minimize any worries about execution time overhead**.

Here is an overview of the most useful functions for argument checking:

### Scalars / Single Objects:

* [checkNull](http://www.rdocumentation.org/packages/checkmate/functions/checkNull)
* [checkFlag](http://www.rdocumentation.org/packages/checkmate/functions/checkFlag)
* [checkNumber](http://www.rdocumentation.org/packages/checkmate/functions/checkNumber)
* [checkCount](http://www.rdocumentation.org/packages/checkmate/functions/checkCount)
* [checkInt](http://www.rdocumentation.org/packages/checkmate/functions/checkInt)
* [checkString](http://www.rdocumentation.org/packages/checkmate/functions/checkString)
* [checkClass](http://www.rdocumentation.org/packages/checkmate/functions/checkClass)
* [checkScalar](http://www.rdocumentation.org/packages/checkmate/functions/checkScalar)
* [checkScalarNA](http://www.rdocumentation.org/packages/checkmate/functions/checkScalarNA)
* [asInt](http://www.rdocumentation.org/packages/checkmate/functions/asInteger)
* [asCount](http://www.rdocumentation.org/packages/checkmate/functions/asInteger)

What can be checked: Simple, non-NA scalars and objects of a specific class.

### Choices and Subsets

* [checkChoice](http://www.rdocumentation.org/packages/checkmate/functions/checkChoice)
* [checkSubset](http://www.rdocumentation.org/packages/checkmate/functions/checkSubset)
* [checkSetEqual](http://www.rdocumentation.org/packages/checkmate/functions/checkSetEqual)

What can be checked: Choices like "A", "B" or "C", subset of those or set equality.

### Vectors and factors:

* [checkLogical](http://www.rdocumentation.org/packages/checkmate/functions/checkLogical)
* [checkNumeric](http://www.rdocumentation.org/packages/checkmate/functions/checkNumeric)
* [checkInteger](http://www.rdocumentation.org/packages/checkmate/functions/checkInteger)
* [checkIntegerish](http://www.rdocumentation.org/packages/checkmate/functions/checkIntegerish)
* [checkComplex](http://www.rdocumentation.org/packages/checkmate/functions/checkComplex)
* [checkCharacter](http://www.rdocumentation.org/packages/checkmate/functions/checkCharacter)
* [checkFactor](http://www.rdocumentation.org/packages/checkmate/functions/checkFactor)
* [checkVector](http://www.rdocumentation.org/packages/checkmate/functions/checkVector)
* [checkAtomic](http://www.rdocumentation.org/packages/checkmate/functions/checkAtomic)
* [checkAtomicVector](http://www.rdocumentation.org/packages/checkmate/functions/checkAtomicVector)
* [asInteger](http://www.rdocumentation.org/packages/checkmate/functions/asInteger)

What can be checked: Length, upper and lower bounds, NAs, duplicates, names.

### Matrices, Arrays and Data Frame:

* [checkMatrix](http://www.rdocumentation.org/packages/checkmate/functions/checkMatrix)
* [checkArray](http://www.rdocumentation.org/packages/checkmate/functions/checkArray)
* [checkDataFrame](http://www.rdocumentation.org/packages/checkmate/functions/checkDataFrame)

What can be checked: Storage mode (numeric, char, etc.), number of rows, cols, NAs, names.

### Lists and Environments:

* [checkList](http://www.rdocumentation.org/packages/checkmate/functions/checkList)
* [checkEnvironment](http://www.rdocumentation.org/packages/checkmate/functions/checkEnvironment)

What can be checked: length, element type, names.

### Functions:

* [checkFunction](http://www.rdocumentation.org/packages/checkmate/functions/checkFunction)

What can be checked: Arguments and ordered arguments.

### File IO:

* [checkFile](http://www.rdocumentation.org/packages/checkmate/functions/checkFile)
* [checkDirectory](http://www.rdocumentation.org/packages/checkmate/functions/checkDirectory)
* [checkPathForOutput](http://www.rdocumentation.org/packages/checkmate/functions/checkPathForOutput)

What can be checked: Path exists, is accessible.

### In case you miss flexibility:

* [assert](http://www.rdocumentation.org/packages/checkmate/functions/assert)

Perform multiple checks at once and throw an assertion if all checks fail.


### Argument Checks for the Lazy

* [qassert](http://www.rdocumentation.org/packages/checkmate/functions/qassert)
* [qassertr](http://www.rdocumentation.org/packages/checkmate/functions/qassert)

These functions allow a special syntax to define argument checks using a special pattern.
E.g., `qassert(x, "I+")` asserts that `x` is an integer vector with at least one element and no missing values.
This provide a completely alternative mini-language (or style) how to perform argument checks.
You choose what you like best.
