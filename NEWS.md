# Version 1.9.0
* Preliminary support for the
  [conditions package](https://github.com/mllg/conditions).
  All assertions now signal an `assertion_error`.
  The checked object `x` is always attached to the raised assertion and can
  be retrieved using `inspectAssertion` or `tryCatch`.
* The set family of functions is now more restrict regarding the class, e.g.
  they differentiate between factors and characters.
* New argument `sorted` (defaults to `FALSE`) for `*Integer`, `*Integerish` and
  `Numeric` to check for ascending order of vector elements.
* New argument `null.ok` (defaults to `FALSE`) for `*Choice` and `*Class`.
* Improved error message for `*Choice`.

# Version 1.8.2
* `*Matrix` and `*Array` now additionally allow to check for integerish storage
  type via argument "mode".
* Functions `*Count`, `*Int`, `*Number`, `*Integer`, `*Integerish` and
  `*Numeric` do not accept logical values any more.
* `checkAtomicVector` is now more restrictive and prohibits a dimension symbol.
  Thus, a matrix is not considered an atomic vector any more.
* Dropped support for AssertCollections in convert functions (`asInt`,
  `asInteger` and `asCount`).
* Added `checkTibble`.

# Version 1.8.1
* Function `test_file` is longer exported.
* `*Function` does not longer lookup functions with `match.fun`. As a result,
  passing functions via the string of the function name stopped working.
* In `qassert` using `f` as first char in a rule now specifies factor (before:
  function).

# Version 1.8.0
* Most functions now support the handling of default arguments encoded as `NULL`
  via argument `null.ok`.
* Functions `*File` and `*Directory` are deprecated due to name clashes and will
  be removed in a future version. Please use `*FileExists` or `*DirectoryExists`
  instead.
* New helper function `matchArg` to provide a simple an easy way for partial
  argument matching in combination with an AssertCollection.
* Added alias functions for all check functions (`check_*`)
  to provide support for the underscore programming style in `assert()`.

# Version 1.7.4
* Compatibility with the upcoming testthat version.
* `expect_` functions now return the checked object invisibly.
* Changed default of argument `.var.name` for assertions and `label` for
  expectations: They now default to the return value of the exported function
  `vname` (instead of missing which confuses some linters).
* Fixed error message in convert functions: Variable name was not properly
  looked up by the heuristic.
* Fixed a bug in `qassertr` and `qtestr` where the error message was not
  properly generated if multiple rules were provided.
* New argument `depth` for `qtestr` to control the recursion depth while
  checking nested lists.

# Version 1.7.3
* Added `checkDate()`.
* Argument `.var.name` of assert functions now has \code{NULL} as default value
  (instead of missing).
* Fixed a bug in `*OS` functions.
* Fixed a bug in `*Directory` functions.
* New argument `extension` for the `*File` family of functions.

# Version 1.7.2
* Added `checkOS()`.
* Argument `fixed` for `*Character` functions now accepts a string instead of a
  boolean value and thus can directly be used for a substring search.
* New arguments `min.chars`, `pattern`, `fixed` and `ignore.case`  for the
  `*String` family of functions.
* Exported helper functions `wf` (which.first) and `wl` (which.last).
* Now importing the new backports package for functions `lengths()` and
  `dir.exists`.

# Version 1.7.1
* Fixed a segfault while checking an upper bound in qassert/qtest.
* Some minor speedups

# Version 1.7.0
* Added alias functions for all functions to support the underscore style, e.g.
  `assert_numeric` is the new alias for `assertNumeric` and `test_matrix` is the
  alias for `test_matrix`.
* All assert functions now invisibly return the tested object instead of `TRUE`
  and thus can be used with magrittr pipes.
* Improved speed for most functions by reducing the .Call overhead (Thanks to
  Hadley Wickham).
* Added `*DataTable` functions to properly test primary and secondary keys of
  data tables.
* Removed `*Percentage` family of functions.
* Exported functions `makeAssertion`, `makeTest` and `makeExpectation` to assist
  expanding the package with user-generated checks.
* Added functions `makeAssertionFunction`, `makeTestFunction` and
  `makeExpectationFunction` to automatically create the respective functions
  based on a provided check function.

# Version 1.6.3
* Assertions can now be collected (via `makeAssertCollection()`) and reported
  (via `reportAssertions()`).
* `qassert()` can now perform bound checks on strings.
* The default for the parameter "ordered" of the `*SetEqual` functions is now
  set to FALSE, as described in the documentation.

# Version 1.6.2
* Fixed a compile-time warning.
* checkmate does not import `testthat` anymore in order to speed up package
  loading times and to keep the dependencies at a minimum. The `expect_*`
  family of functions can still be used, the namespace will be loaded on
  demand.

# Version 1.6.1
* New family of functions: `expect_*` is intended to be used in combination
  with testthat. But note that functions `expect_null()` and `expect_named()`
  are not provided to avoid name clashes with testthat.
* Added `qexpect()` and `qexpectr()`.
* Added argument `all.missing` for checks of matricies and data frames.
* Added `anyNaN()`.
* Clarified documentation for `assert()` and `allMissing()`.
* Fixed a bug where bound checks were performed on missing values.
* Fixed a bug where missingness was not correctly detected in data frames.

# Version 1.6.0
* Started to support long vectors.
* Added a short vignette.
* Improved documentation.
* New argument "combine" for `assert()` to allow combining check functions with
  an AND instead of an OR.

# Version 1.5.3
* Fixed a bug regarding the number of rows in zero-column data frames.
* Fixed a bug where the type of lists with dimension attribute where reported
  as "array" or "matrix".
* Family *Array: new arguments "min.d" and "max.d".
* Family *Array and *Matrix: Argument "mode" now additionally accepts strings
  "list" and "atomic".

# Version 1.5.2
* Fixed: `(assert|check|test)Character(NA_character_, min.chars = 1)` does not
  eval to TRUE anymore.
* New arguments for `*Factor` functions: `(n|min|max).levels`.
* Improved error messages for type and length checks.
* Improved error messages for missing arguments.

# Version 1.5.1
* Included a workaround for R's nrow and ncol to properly work with data frames.
* Fixed a bug handling complex number in checks for integerish values.
* Improved documentation.

# Version 1.5.0
* Added `checkNames()`.
* Added `checkPercentage()`.
* Added `anyInfinite()`.
* Fixed error messages for some dimension checks.
* Fixed an error while checking numerics for finiteness.

# Version 1.4
* Fixed a bug where rownames and colnames of data.frames where not retrieved
  correctly.
* Fixed a bug in `checkVector()` (wrong order of arguments in call to C).
* Filesystem access: checks for write and executable rights are now disabled
  on windows.

# Version 1.3
* Fixed a bug where logical values passed a check for numerics in `qassert`.
* Family `*SetEqual`: new argument "ordered".
* `checkPathForOutput`: new argument "overwrite".

# Version 1.2
* Fixed bug in checkList.
* Fixed dimnames check on empty matrices and data frames.
* Added `*SetEqual` functions.

# Version 1.1
* Improved error messages in `assert*` functions.
* New argument 'empty.ok' for `*Subset` functions.
* `assert()` now returns TRUE invisibly (as documented).
* Fixed handling of zero-length arguments in `checkFunction()`.
* Fixed error message if duplicated values where found.
* Fixed a missing check for row names in `checkMatrix()` and `checkDataFrame()`.

# Version 1.0
* Initial release on CRAN.
