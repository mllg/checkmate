# checkmate

Fast and versatile argument checks for R.

* Travis CI: [![Build Status](https://travis-ci.org/mllg/checkmate.svg)](https://travis-ci.org/mllg/checkmate)


Ever used an R function that produced a not-very-helpful error message,
just to discover after minutes of debugging that you simply passed a wrong argument?

Blaming the laziness of the package author for not doing such standard checks
(in a dynamically typed language such as R) is at least partially unfair, as R makes theses types of checks
cumbersome and annoying. Well, that's how it was in the past.

Enter checkmate.

Virtually **every standard type of user error** when passing arguments into function can be
caught with a simple, readable line which produces an **informative error message** in case.
A substantial part of the package was written in C to **minimize any worries about execution time overhead**.

Here is quick example to get you started at once. Let's look at the function
[makeSimpleFileLogger](http://berndbischl.github.io/BBmisc/man/makeSimpleFileLogger.html)
in our [BBmisc](http://berndbischl.github.io/BBmisc/) helper package.
As you can see, a file path, a boolean flag and a count can be passed in by the
user. Here is the corresponding code to perform the checks:

```splus
makeSimpleFileLogger = function(logfile, touch = FALSE, keep = 10L) {
  assertFile(logfile)
  assertFlag(touch)
  keep = asInt(keep, lower = 0L)

  ....
}

```
The last line not only does the assertion for the integer "keep", it also auto-converts numeric-coded integers to the actual integer data type
of R, so `1` becomes `1L`.

Here is what happens if you perform wrong inputs:


```splus
makeSimpleFileLogger(logfile = 444)
>  Assertion on 'x' failed. Must be of class 'string', not 'double'

makeSimpleFileLogger(logfile = "/wrongpath/myfile.log")
>  Assertion on 'logfile' failed: File does not exist: '/wrongpath/myfile.log'

makeSimpleFileLogger(logfile = "log.txt", keep = -20L)
>  Assertion on 'logfile' failed: File does not exist: 'log.txt'

```

Here is an overview of the most useful functions for argument checking:

### Scalars / Single Objects:

* [checkNull](http://mllg.github.io/checkmate/man/checkNull.html)
* [checkFlag](http://mllg.github.io/checkmate/man/checkFlag.html)
* [checkNumber](http://mllg.github.io/checkmate/man/checkNumber.html)
* [checkCount](http://mllg.github.io/checkmate/man/checkCount.html)
* [checkInt](http://mllg.github.io/checkmate/man/checkInt.html)
* [checkString](http://mllg.github.io/checkmate/man/checkString.html)
* [checkClass](http://mllg.github.io/checkmate/man/checkClass.html)
* [asInt](http://mllg.github.io/checkmate/man/asInt.html)
* [asCount](http://mllg.github.io/checkmate/man/asInt.html)

What can be checked: Simple, non-NA scalars and objects of a specific class.

### Choices and Subsets

* [checkChoice](http://mllg.github.io/checkmate/man/checkChoice.html)
* [checkSubset](http://mllg.github.io/checkmate/man/checkSubset.html)

What can be checked: Choices like "A", "B" or "C" or a subset of those.

### Vectors and factors:

* [checkLogical](http://mllg.github.io/checkmate/man/checkLogical.html)
* [checkNumeric](http://mllg.github.io/checkmate/man/checkNumeric.html)
* [checkInteger](http://mllg.github.io/checkmate/man/checkInteger.html)
* [checkIntegerish](http://mllg.github.io/checkmate/man/checkIntegerish.html)
* [asInteger](http://mllg.github.io/checkmate/man/asInteger.html)
* [checkComplex](http://mllg.github.io/checkmate/man/checkComplex.html)
* [checkCharacter](http://mllg.github.io/checkmate/man/checkCharacter.html)
* [checkFactor](http://mllg.github.io/checkmate/man/checkFactor.html)
* [checkVector](http://mllg.github.io/checkmate/man/checkVector.html)
* [checkAtomic](http://mllg.github.io/checkmate/man/checkAtomic.html)
* [checkAtomicVector](http://mllg.github.io/checkmate/man/checkAtomicVector.html)
* [asInteger](http://mllg.github.io/checkmate/man/asInteger.html)

What can be checked: Length, upper and lower bounds, NAs.

### Matrices, Arrays and Data Frame:

* [checkMatrix](http://mllg.github.io/checkmate/man/checkMatrix.html)
* [checkArray](http://mllg.github.io/checkmate/man/checkArray.html)
* [checkDataFrame](http://mllg.github.io/checkmate/man/checkDataFrame.html)

What can be checked: Storage mode (numeric, char, etc.), number of rows, cols, NAs, names.

### Lists and Environments:

* [checkList](http://mllg.github.io/checkmate/man/checkList.html)
* [checkEnvironment](http://mllg.github.io/checkmate/man/checkEnvironment.html)

What can be checked: length, element type, names.

### Functions:

* [checkFunction](http://mllg.github.io/checkmate/man/checkFunction.html)

What can be checked: Arguments and ordered arguments.

### File IO:

* [checkFile](http://mllg.github.io/checkmate/man/checkFile.html)
* [checkDirectory](http://mllg.github.io/checkmate/man/checkDirectory.html)

What can be checked: Path exists, is accessible.

### Argument Checks for the Lazy

* [qassert](http://mllg.github.io/checkmate/man/qassert.html)
* [qassertr](http://mllg.github.io/checkmate/man/qassert.html)

These functions allow a special syntax to define argument checks using
a special pattern. E.g., `qassert(x, "I+")` asserts that `x` is an integer
vector with at least one element and no missing values.
This provide a completely alternative mini-language (or style) how to perform arg checks.
You choose what you like best.
