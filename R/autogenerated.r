### auto-generated functions for checkAccess ############################################################################

#' @rdname checkAccess
#' @export
assertAccess = function(x, access = "", add = NULL, .var.name) {
  res = checkAccess(x, access)
  makeAssertion(x, res, vname(x, .var.name), add)
}

#' @rdname checkAccess
#' @export
assert_access = assertAccess

#' @rdname checkAccess
#' @export
testAccess = function(x, access = "") {
  isTRUE(checkAccess(x, access))
}

#' @rdname checkAccess
#' @export
test_access = testAccess

#' @rdname checkAccess
#' @template expect
#' @export
expect_access = function(x, access = "", info = NULL, label = NULL) {
  res = checkAccess(x, access)
  makeExpectation(res, info = info, label = vname(x, label))
}


### auto-generated functions for checkArray ############################################################################

#' @rdname checkArray
#' @export
assertArray = function(x, mode = NULL, any.missing = TRUE, d = NULL, min.d = NULL, max.d = NULL, add = NULL, .var.name) {
  res = checkArray(x, mode, any.missing, d, min.d, max.d)
  makeAssertion(x, res, vname(x, .var.name), add)
}

#' @rdname checkArray
#' @export
assert_array = assertArray

#' @rdname checkArray
#' @export
testArray = function(x, mode = NULL, any.missing = TRUE, d = NULL, min.d = NULL, max.d = NULL) {
  isTRUE(checkArray(x, mode, any.missing, d, min.d, max.d))
}

#' @rdname checkArray
#' @export
test_array = testArray

#' @rdname checkArray
#' @template expect
#' @export
expect_array = function(x, mode = NULL, any.missing = TRUE, d = NULL, min.d = NULL, max.d = NULL, info = NULL, label = NULL) {
  res = checkArray(x, mode, any.missing, d, min.d, max.d)
  makeExpectation(res, info = info, label = vname(x, label))
}


### auto-generated functions for checkAtomic ############################################################################

#' @rdname checkAtomic
#' @export
assertAtomic = function(x, any.missing = TRUE, all.missing = TRUE, len = NULL, min.len = NULL, max.len = NULL, unique = FALSE, names = NULL, add = NULL, .var.name) {
  res = checkAtomic(x, any.missing, all.missing, len, min.len, max.len, unique, names)
  makeAssertion(x, res, vname(x, .var.name), add)
}

#' @rdname checkAtomic
#' @export
assert_atomic = assertAtomic

#' @rdname checkAtomic
#' @export
testAtomic = function(x, any.missing = TRUE, all.missing = TRUE, len = NULL, min.len = NULL, max.len = NULL, unique = FALSE, names = NULL) {
  isTRUE(checkAtomic(x, any.missing, all.missing, len, min.len, max.len, unique, names))
}

#' @rdname checkAtomic
#' @export
test_atomic = testAtomic

#' @rdname checkAtomic
#' @template expect
#' @export
expect_atomic = function(x, any.missing = TRUE, all.missing = TRUE, len = NULL, min.len = NULL, max.len = NULL, unique = FALSE, names = NULL, info = NULL, label = NULL) {
  res = checkAtomic(x, any.missing, all.missing, len, min.len, max.len, unique, names)
  makeExpectation(res, info = info, label = vname(x, label))
}


### auto-generated functions for checkAtomicVector ############################################################################

#' @rdname checkAtomicVector
#' @export
assertAtomicVector = function(x, any.missing = TRUE, all.missing = TRUE, len = NULL, min.len = NULL, max.len = NULL, unique = FALSE, names = NULL, add = NULL, .var.name) {
  res = checkAtomicVector(x, any.missing, all.missing, len, min.len, max.len, unique, names)
  makeAssertion(x, res, vname(x, .var.name), add)
}

#' @rdname checkAtomicVector
#' @export
assert_atomic_vector = assertAtomicVector

#' @rdname checkAtomicVector
#' @export
testAtomicVector = function(x, any.missing = TRUE, all.missing = TRUE, len = NULL, min.len = NULL, max.len = NULL, unique = FALSE, names = NULL) {
  isTRUE(checkAtomicVector(x, any.missing, all.missing, len, min.len, max.len, unique, names))
}

#' @rdname checkAtomicVector
#' @export
test_atomic_vector = testAtomicVector

#' @rdname checkAtomicVector
#' @template expect
#' @export
expect_atomic_vector = function(x, any.missing = TRUE, all.missing = TRUE, len = NULL, min.len = NULL, max.len = NULL, unique = FALSE, names = NULL, info = NULL, label = NULL) {
  res = checkAtomicVector(x, any.missing, all.missing, len, min.len, max.len, unique, names)
  makeExpectation(res, info = info, label = vname(x, label))
}


### auto-generated functions for checkCharacter ############################################################################

#' @rdname checkCharacter
#' @export
assertCharacter = function(x, min.chars = NULL, pattern = NULL, fixed = FALSE, ignore.case = FALSE, any.missing = TRUE, all.missing = TRUE, len = NULL, min.len = NULL, max.len = NULL, unique = FALSE, names = NULL, add = NULL, .var.name) {
  res = checkCharacter(x, min.chars, pattern, fixed, ignore.case, any.missing, all.missing, len, min.len, max.len, unique, names)
  makeAssertion(x, res, vname(x, .var.name), add)
}

#' @rdname checkCharacter
#' @export
assert_character = assertCharacter

#' @rdname checkCharacter
#' @export
testCharacter = function(x, min.chars = NULL, pattern = NULL, fixed = FALSE, ignore.case = FALSE, any.missing = TRUE, all.missing = TRUE, len = NULL, min.len = NULL, max.len = NULL, unique = FALSE, names = NULL) {
  isTRUE(checkCharacter(x, min.chars, pattern, fixed, ignore.case, any.missing, all.missing, len, min.len, max.len, unique, names))
}

#' @rdname checkCharacter
#' @export
test_character = testCharacter

#' @rdname checkCharacter
#' @template expect
#' @export
expect_character = function(x, min.chars = NULL, pattern = NULL, fixed = FALSE, ignore.case = FALSE, any.missing = TRUE, all.missing = TRUE, len = NULL, min.len = NULL, max.len = NULL, unique = FALSE, names = NULL, info = NULL, label = NULL) {
  res = checkCharacter(x, min.chars, pattern, fixed, ignore.case, any.missing, all.missing, len, min.len, max.len, unique, names)
  makeExpectation(res, info = info, label = vname(x, label))
}


### auto-generated functions for checkChoice ############################################################################

#' @rdname checkChoice
#' @export
assertChoice = function(x, choices, add = NULL, .var.name) {
  res = checkChoice(x, choices)
  makeAssertion(x, res, vname(x, .var.name), add)
}

#' @rdname checkChoice
#' @export
assert_choice = assertChoice

#' @rdname checkChoice
#' @export
testChoice = function(x, choices) {
  isTRUE(checkChoice(x, choices))
}

#' @rdname checkChoice
#' @export
test_choice = testChoice

#' @rdname checkChoice
#' @template expect
#' @export
expect_choice = function(x, choices, info = NULL, label = NULL) {
  res = checkChoice(x, choices)
  makeExpectation(res, info = info, label = vname(x, label))
}


### auto-generated functions for checkClass ############################################################################

#' @rdname checkClass
#' @export
assertClass = function(x, classes, ordered = FALSE, add = NULL, .var.name) {
  res = checkClass(x, classes, ordered)
  makeAssertion(x, res, vname(x, .var.name), add)
}

#' @rdname checkClass
#' @export
assert_class = assertClass

#' @rdname checkClass
#' @export
testClass = function(x, classes, ordered = FALSE) {
  isTRUE(checkClass(x, classes, ordered))
}

#' @rdname checkClass
#' @export
test_class = testClass

#' @rdname checkClass
#' @template expect
#' @export
expect_class = function(x, classes, ordered = FALSE, info = NULL, label = NULL) {
  res = checkClass(x, classes, ordered)
  makeExpectation(res, info = info, label = vname(x, label))
}


### auto-generated functions for checkComplex ############################################################################

#' @rdname checkComplex
#' @export
assertComplex = function(x, any.missing = TRUE, all.missing = TRUE, len = NULL, min.len = NULL, max.len = NULL, unique = FALSE, names = NULL, add = NULL, .var.name) {
  res = checkComplex(x, any.missing, all.missing, len, min.len, max.len, unique, names)
  makeAssertion(x, res, vname(x, .var.name), add)
}

#' @rdname checkComplex
#' @export
assert_complex = assertComplex

#' @rdname checkComplex
#' @export
testComplex = function(x, any.missing = TRUE, all.missing = TRUE, len = NULL, min.len = NULL, max.len = NULL, unique = FALSE, names = NULL) {
  isTRUE(checkComplex(x, any.missing, all.missing, len, min.len, max.len, unique, names))
}

#' @rdname checkComplex
#' @export
test_complex = testComplex

#' @rdname checkComplex
#' @template expect
#' @export
expect_complex = function(x, any.missing = TRUE, all.missing = TRUE, len = NULL, min.len = NULL, max.len = NULL, unique = FALSE, names = NULL, info = NULL, label = NULL) {
  res = checkComplex(x, any.missing, all.missing, len, min.len, max.len, unique, names)
  makeExpectation(res, info = info, label = vname(x, label))
}


### auto-generated functions for checkCount ############################################################################

#' @rdname checkCount
#' @export
assertCount = function(x, na.ok = FALSE, positive = FALSE, tol = sqrt(.Machine$double.eps), add = NULL, .var.name) {
  res = checkCount(x, na.ok, positive, tol)
  makeAssertion(x, res, vname(x, .var.name), add)
}

#' @rdname checkCount
#' @export
assert_count = assertCount

#' @rdname checkCount
#' @export
testCount = function(x, na.ok = FALSE, positive = FALSE, tol = sqrt(.Machine$double.eps)) {
  isTRUE(checkCount(x, na.ok, positive, tol))
}

#' @rdname checkCount
#' @export
test_count = testCount

#' @rdname checkCount
#' @template expect
#' @export
expect_count = function(x, na.ok = FALSE, positive = FALSE, tol = sqrt(.Machine$double.eps), info = NULL, label = NULL) {
  res = checkCount(x, na.ok, positive, tol)
  makeExpectation(res, info = info, label = vname(x, label))
}


### auto-generated functions for checkDataFrame ############################################################################

#' @rdname checkDataFrame
#' @export
assertDataFrame = function(x, types = character(0L), any.missing = TRUE, all.missing = TRUE, min.rows = NULL, min.cols = NULL, nrows = NULL, ncols = NULL, row.names = NULL, col.names = NULL, add = NULL, .var.name) {
  res = checkDataFrame(x, types, any.missing, all.missing, min.rows, min.cols, nrows, ncols, row.names, col.names)
  makeAssertion(x, res, vname(x, .var.name), add)
}

#' @rdname checkDataFrame
#' @export
assert_data_frame = assertDataFrame

#' @rdname checkDataFrame
#' @export
testDataFrame = function(x, types = character(0L), any.missing = TRUE, all.missing = TRUE, min.rows = NULL, min.cols = NULL, nrows = NULL, ncols = NULL, row.names = NULL, col.names = NULL) {
  isTRUE(checkDataFrame(x, types, any.missing, all.missing, min.rows, min.cols, nrows, ncols, row.names, col.names))
}

#' @rdname checkDataFrame
#' @export
test_data_frame = testDataFrame

#' @rdname checkDataFrame
#' @template expect
#' @export
expect_data_frame = function(x, types = character(0L), any.missing = TRUE, all.missing = TRUE, min.rows = NULL, min.cols = NULL, nrows = NULL, ncols = NULL, row.names = NULL, col.names = NULL, info = NULL, label = NULL) {
  res = checkDataFrame(x, types, any.missing, all.missing, min.rows, min.cols, nrows, ncols, row.names, col.names)
  makeExpectation(res, info = info, label = vname(x, label))
}


### auto-generated functions for checkDataTable ############################################################################

#' @rdname checkDataTable
#' @export
assertDataTable = function(x, key = NULL, index = NULL, types = character(0L), any.missing = TRUE, all.missing = TRUE, min.rows = NULL, min.cols = NULL, nrows = NULL, ncols = NULL, row.names = NULL, col.names = NULL, add = NULL, .var.name) {
  res = checkDataTable(x, key, index, types, any.missing, all.missing, min.rows, min.cols, nrows, ncols, row.names, col.names)
  makeAssertion(x, res, vname(x, .var.name), add)
}

#' @rdname checkDataTable
#' @export
assert_data_table = assertDataTable

#' @rdname checkDataTable
#' @export
testDataTable = function(x, key = NULL, index = NULL, types = character(0L), any.missing = TRUE, all.missing = TRUE, min.rows = NULL, min.cols = NULL, nrows = NULL, ncols = NULL, row.names = NULL, col.names = NULL) {
  isTRUE(checkDataTable(x, key, index, types, any.missing, all.missing, min.rows, min.cols, nrows, ncols, row.names, col.names))
}

#' @rdname checkDataTable
#' @export
test_data_table = testDataTable

#' @rdname checkDataTable
#' @template expect
#' @export
expect_data_table = function(x, key = NULL, index = NULL, types = character(0L), any.missing = TRUE, all.missing = TRUE, min.rows = NULL, min.cols = NULL, nrows = NULL, ncols = NULL, row.names = NULL, col.names = NULL, info = NULL, label = NULL) {
  res = checkDataTable(x, key, index, types, any.missing, all.missing, min.rows, min.cols, nrows, ncols, row.names, col.names)
  makeExpectation(res, info = info, label = vname(x, label))
}


### auto-generated functions for checkDirectory ############################################################################

#' @rdname checkDirectory
#' @export
assertDirectory = function(x, access = "", add = NULL, .var.name) {
  res = checkDirectory(x, access)
  makeAssertion(x, res, vname(x, .var.name), add)
}

#' @rdname checkDirectory
#' @export
assert_directory = assertDirectory

#' @rdname checkDirectory
#' @export
testDirectory = function(x, access = "") {
  isTRUE(checkDirectory(x, access))
}

#' @rdname checkDirectory
#' @export
test_directory = testDirectory

#' @rdname checkDirectory
#' @template expect
#' @export
expect_directory = function(x, access = "", info = NULL, label = NULL) {
  res = checkDirectory(x, access)
  makeExpectation(res, info = info, label = vname(x, label))
}


### auto-generated functions for checkEnvironment ############################################################################

#' @rdname checkEnvironment
#' @export
assertEnvironment = function(x, contains = character(0L), add = NULL, .var.name) {
  res = checkEnvironment(x, contains)
  makeAssertion(x, res, vname(x, .var.name), add)
}

#' @rdname checkEnvironment
#' @export
assert_environment = assertEnvironment

#' @rdname checkEnvironment
#' @export
testEnvironment = function(x, contains = character(0L)) {
  isTRUE(checkEnvironment(x, contains))
}

#' @rdname checkEnvironment
#' @export
test_environment = testEnvironment

#' @rdname checkEnvironment
#' @template expect
#' @export
expect_environment = function(x, contains = character(0L), info = NULL, label = NULL) {
  res = checkEnvironment(x, contains)
  makeExpectation(res, info = info, label = vname(x, label))
}


### auto-generated functions for checkFactor ############################################################################

#' @rdname checkFactor
#' @export
assertFactor = function(x, levels = NULL, ordered = NA, empty.levels.ok = TRUE, any.missing = TRUE, all.missing = TRUE, len = NULL, min.len = NULL, max.len = NULL, n.levels = NULL, min.levels = NULL, max.levels = NULL, unique = FALSE, names = NULL, add = NULL, .var.name) {
  res = checkFactor(x, levels, ordered, empty.levels.ok, any.missing, all.missing, len, min.len, max.len, n.levels, min.levels, max.levels, unique, names)
  makeAssertion(x, res, vname(x, .var.name), add)
}

#' @rdname checkFactor
#' @export
assert_factor = assertFactor

#' @rdname checkFactor
#' @export
testFactor = function(x, levels = NULL, ordered = NA, empty.levels.ok = TRUE, any.missing = TRUE, all.missing = TRUE, len = NULL, min.len = NULL, max.len = NULL, n.levels = NULL, min.levels = NULL, max.levels = NULL, unique = FALSE, names = NULL) {
  isTRUE(checkFactor(x, levels, ordered, empty.levels.ok, any.missing, all.missing, len, min.len, max.len, n.levels, min.levels, max.levels, unique, names))
}

#' @rdname checkFactor
#' @export
test_factor = testFactor

#' @rdname checkFactor
#' @template expect
#' @export
expect_factor = function(x, levels = NULL, ordered = NA, empty.levels.ok = TRUE, any.missing = TRUE, all.missing = TRUE, len = NULL, min.len = NULL, max.len = NULL, n.levels = NULL, min.levels = NULL, max.levels = NULL, unique = FALSE, names = NULL, info = NULL, label = NULL) {
  res = checkFactor(x, levels, ordered, empty.levels.ok, any.missing, all.missing, len, min.len, max.len, n.levels, min.levels, max.levels, unique, names)
  makeExpectation(res, info = info, label = vname(x, label))
}


### auto-generated functions for checkFile ############################################################################

#' @rdname checkFile
#' @export
assertFile = function(x, access = "", add = NULL, .var.name) {
  res = checkFile(x, access)
  makeAssertion(x, res, vname(x, .var.name), add)
}

#' @rdname checkFile
#' @export
assert_file = assertFile

#' @rdname checkFile
#' @export
testFile = function(x, access = "") {
  isTRUE(checkFile(x, access))
}

#' @rdname checkFile
#' @export
test_file = testFile

#' @rdname checkFile
#' @template expect
#' @export
expect_file = function(x, access = "", info = NULL, label = NULL) {
  res = checkFile(x, access)
  makeExpectation(res, info = info, label = vname(x, label))
}


### auto-generated functions for checkFlag ############################################################################

#' @rdname checkFlag
#' @export
assertFlag = function(x, na.ok = FALSE, add = NULL, .var.name) {
  res = checkFlag(x, na.ok)
  makeAssertion(x, res, vname(x, .var.name), add)
}

#' @rdname checkFlag
#' @export
assert_flag = assertFlag

#' @rdname checkFlag
#' @export
testFlag = function(x, na.ok = FALSE) {
  isTRUE(checkFlag(x, na.ok))
}

#' @rdname checkFlag
#' @export
test_flag = testFlag

#' @rdname checkFlag
#' @template expect
#' @export
expect_flag = function(x, na.ok = FALSE, info = NULL, label = NULL) {
  res = checkFlag(x, na.ok)
  makeExpectation(res, info = info, label = vname(x, label))
}


### auto-generated functions for checkFunction ############################################################################

#' @rdname checkFunction
#' @export
assertFunction = function(x, args = NULL, ordered = FALSE, nargs = NULL, add = NULL, .var.name) {
  res = checkFunction(x, args, ordered, nargs)
  makeAssertion(x, res, vname(x, .var.name), add)
}

#' @rdname checkFunction
#' @export
assert_function = assertFunction

#' @rdname checkFunction
#' @export
testFunction = function(x, args = NULL, ordered = FALSE, nargs = NULL) {
  isTRUE(checkFunction(x, args, ordered, nargs))
}

#' @rdname checkFunction
#' @export
test_function = testFunction

#' @rdname checkFunction
#' @template expect
#' @export
expect_function = function(x, args = NULL, ordered = FALSE, nargs = NULL, info = NULL, label = NULL) {
  res = checkFunction(x, args, ordered, nargs)
  makeExpectation(res, info = info, label = vname(x, label))
}


### auto-generated functions for checkInt ############################################################################

#' @rdname checkInt
#' @export
assertInt = function(x, na.ok = FALSE, lower = -Inf, upper = Inf, tol = sqrt(.Machine$double.eps), add = NULL, .var.name) {
  res = checkInt(x, na.ok, lower, upper, tol)
  makeAssertion(x, res, vname(x, .var.name), add)
}

#' @rdname checkInt
#' @export
assert_int = assertInt

#' @rdname checkInt
#' @export
testInt = function(x, na.ok = FALSE, lower = -Inf, upper = Inf, tol = sqrt(.Machine$double.eps)) {
  isTRUE(checkInt(x, na.ok, lower, upper, tol))
}

#' @rdname checkInt
#' @export
test_int = testInt

#' @rdname checkInt
#' @template expect
#' @export
expect_int = function(x, na.ok = FALSE, lower = -Inf, upper = Inf, tol = sqrt(.Machine$double.eps), info = NULL, label = NULL) {
  res = checkInt(x, na.ok, lower, upper, tol)
  makeExpectation(res, info = info, label = vname(x, label))
}


### auto-generated functions for checkInteger ############################################################################

#' @rdname checkInteger
#' @export
assertInteger = function(x, lower = -Inf, upper = Inf, any.missing = TRUE, all.missing = TRUE, len = NULL, min.len = NULL, max.len = NULL, unique = FALSE, names = NULL, add = NULL, .var.name) {
  res = checkInteger(x, lower, upper, any.missing, all.missing, len, min.len, max.len, unique, names)
  makeAssertion(x, res, vname(x, .var.name), add)
}

#' @rdname checkInteger
#' @export
assert_integer = assertInteger

#' @rdname checkInteger
#' @export
testInteger = function(x, lower = -Inf, upper = Inf, any.missing = TRUE, all.missing = TRUE, len = NULL, min.len = NULL, max.len = NULL, unique = FALSE, names = NULL) {
  isTRUE(checkInteger(x, lower, upper, any.missing, all.missing, len, min.len, max.len, unique, names))
}

#' @rdname checkInteger
#' @export
test_integer = testInteger

#' @rdname checkInteger
#' @template expect
#' @export
expect_integer = function(x, lower = -Inf, upper = Inf, any.missing = TRUE, all.missing = TRUE, len = NULL, min.len = NULL, max.len = NULL, unique = FALSE, names = NULL, info = NULL, label = NULL) {
  res = checkInteger(x, lower, upper, any.missing, all.missing, len, min.len, max.len, unique, names)
  makeExpectation(res, info = info, label = vname(x, label))
}


### auto-generated functions for checkIntegerish ############################################################################

#' @rdname checkIntegerish
#' @export
assertIntegerish = function(x, tol = sqrt(.Machine$double.eps), lower = -Inf, upper = Inf, any.missing = TRUE, all.missing = TRUE, len = NULL, min.len = NULL, max.len = NULL, unique = FALSE, names = NULL, add = NULL, .var.name) {
  res = checkIntegerish(x, tol, lower, upper, any.missing, all.missing, len, min.len, max.len, unique, names)
  makeAssertion(x, res, vname(x, .var.name), add)
}

#' @rdname checkIntegerish
#' @export
assert_integerish = assertIntegerish

#' @rdname checkIntegerish
#' @export
testIntegerish = function(x, tol = sqrt(.Machine$double.eps), lower = -Inf, upper = Inf, any.missing = TRUE, all.missing = TRUE, len = NULL, min.len = NULL, max.len = NULL, unique = FALSE, names = NULL) {
  isTRUE(checkIntegerish(x, tol, lower, upper, any.missing, all.missing, len, min.len, max.len, unique, names))
}

#' @rdname checkIntegerish
#' @export
test_integerish = testIntegerish

#' @rdname checkIntegerish
#' @template expect
#' @export
expect_integerish = function(x, tol = sqrt(.Machine$double.eps), lower = -Inf, upper = Inf, any.missing = TRUE, all.missing = TRUE, len = NULL, min.len = NULL, max.len = NULL, unique = FALSE, names = NULL, info = NULL, label = NULL) {
  res = checkIntegerish(x, tol, lower, upper, any.missing, all.missing, len, min.len, max.len, unique, names)
  makeExpectation(res, info = info, label = vname(x, label))
}


### auto-generated functions for checkList ############################################################################

#' @rdname checkList
#' @export
assertList = function(x, types = character(0L), any.missing = TRUE, all.missing = TRUE, len = NULL, min.len = NULL, max.len = NULL, unique = FALSE, names = NULL, add = NULL, .var.name) {
  res = checkList(x, types, any.missing, all.missing, len, min.len, max.len, unique, names)
  makeAssertion(x, res, vname(x, .var.name), add)
}

#' @rdname checkList
#' @export
assert_list = assertList

#' @rdname checkList
#' @export
testList = function(x, types = character(0L), any.missing = TRUE, all.missing = TRUE, len = NULL, min.len = NULL, max.len = NULL, unique = FALSE, names = NULL) {
  isTRUE(checkList(x, types, any.missing, all.missing, len, min.len, max.len, unique, names))
}

#' @rdname checkList
#' @export
test_list = testList

#' @rdname checkList
#' @template expect
#' @export
expect_list = function(x, types = character(0L), any.missing = TRUE, all.missing = TRUE, len = NULL, min.len = NULL, max.len = NULL, unique = FALSE, names = NULL, info = NULL, label = NULL) {
  res = checkList(x, types, any.missing, all.missing, len, min.len, max.len, unique, names)
  makeExpectation(res, info = info, label = vname(x, label))
}


### auto-generated functions for checkLogical ############################################################################

#' @rdname checkLogical
#' @export
assertLogical = function(x, any.missing = TRUE, all.missing = TRUE, len = NULL, min.len = NULL, max.len = NULL, unique = FALSE, names = NULL, add = NULL, .var.name) {
  res = checkLogical(x, any.missing, all.missing, len, min.len, max.len, unique, names)
  makeAssertion(x, res, vname(x, .var.name), add)
}

#' @rdname checkLogical
#' @export
assert_logical = assertLogical

#' @rdname checkLogical
#' @export
testLogical = function(x, any.missing = TRUE, all.missing = TRUE, len = NULL, min.len = NULL, max.len = NULL, unique = FALSE, names = NULL) {
  isTRUE(checkLogical(x, any.missing, all.missing, len, min.len, max.len, unique, names))
}

#' @rdname checkLogical
#' @export
test_logical = testLogical

#' @rdname checkLogical
#' @template expect
#' @export
expect_logical = function(x, any.missing = TRUE, all.missing = TRUE, len = NULL, min.len = NULL, max.len = NULL, unique = FALSE, names = NULL, info = NULL, label = NULL) {
  res = checkLogical(x, any.missing, all.missing, len, min.len, max.len, unique, names)
  makeExpectation(res, info = info, label = vname(x, label))
}


### auto-generated functions for checkMatrix ############################################################################

#' @rdname checkMatrix
#' @export
assertMatrix = function(x, mode = NULL, any.missing = TRUE, all.missing = TRUE, min.rows = NULL, min.cols = NULL, nrows = NULL, ncols = NULL, row.names = NULL, col.names = NULL, add = NULL, .var.name) {
  res = checkMatrix(x, mode, any.missing, all.missing, min.rows, min.cols, nrows, ncols, row.names, col.names)
  makeAssertion(x, res, vname(x, .var.name), add)
}

#' @rdname checkMatrix
#' @export
assert_matrix = assertMatrix

#' @rdname checkMatrix
#' @export
testMatrix = function(x, mode = NULL, any.missing = TRUE, all.missing = TRUE, min.rows = NULL, min.cols = NULL, nrows = NULL, ncols = NULL, row.names = NULL, col.names = NULL) {
  isTRUE(checkMatrix(x, mode, any.missing, all.missing, min.rows, min.cols, nrows, ncols, row.names, col.names))
}

#' @rdname checkMatrix
#' @export
test_matrix = testMatrix

#' @rdname checkMatrix
#' @template expect
#' @export
expect_matrix = function(x, mode = NULL, any.missing = TRUE, all.missing = TRUE, min.rows = NULL, min.cols = NULL, nrows = NULL, ncols = NULL, row.names = NULL, col.names = NULL, info = NULL, label = NULL) {
  res = checkMatrix(x, mode, any.missing, all.missing, min.rows, min.cols, nrows, ncols, row.names, col.names)
  makeExpectation(res, info = info, label = vname(x, label))
}


### auto-generated functions for checkNamed ############################################################################

#' @rdname checkNamed
#' @export
assertNamed = function(x, type = "named", add = NULL, .var.name) {
  res = checkNamed(x, type)
  makeAssertion(x, res, vname(x, .var.name), add)
}

#' @rdname checkNamed
#' @export
assert_named = assertNamed

#' @rdname checkNamed
#' @export
testNamed = function(x, type = "named") {
  isTRUE(checkNamed(x, type))
}

#' @rdname checkNamed
#' @export
test_named = testNamed



### auto-generated functions for checkNames ############################################################################

#' @rdname checkNames
#' @export
assertNames = function(x, type = "named", add = NULL, .var.name) {
  res = checkNames(x, type)
  makeAssertion(x, res, vname(x, .var.name), add)
}

#' @rdname checkNames
#' @export
assert_names = assertNames

#' @rdname checkNames
#' @export
testNames = function(x, type = "named") {
  isTRUE(checkNames(x, type))
}

#' @rdname checkNames
#' @export
test_names = testNames

#' @rdname checkNames
#' @template expect
#' @export
expect_names = function(x, type = "named", info = NULL, label = NULL) {
  res = checkNames(x, type)
  makeExpectation(res, info = info, label = vname(x, label))
}


### auto-generated functions for checkNull ############################################################################

#' @rdname checkNull
#' @export
assertNull = function(x, add = NULL, .var.name) {
  res = checkNull(x)
  makeAssertion(x, res, vname(x, .var.name), add)
}

#' @rdname checkNull
#' @export
assert_null = assertNull

#' @rdname checkNull
#' @export
testNull = function(x) {
  isTRUE(checkNull(x))
}

#' @rdname checkNull
#' @export
test_null = testNull



### auto-generated functions for checkNumber ############################################################################

#' @rdname checkNumber
#' @export
assertNumber = function(x, na.ok = FALSE, lower = -Inf, upper = Inf, finite = FALSE, add = NULL, .var.name) {
  res = checkNumber(x, na.ok, lower, upper, finite)
  makeAssertion(x, res, vname(x, .var.name), add)
}

#' @rdname checkNumber
#' @export
assert_number = assertNumber

#' @rdname checkNumber
#' @export
testNumber = function(x, na.ok = FALSE, lower = -Inf, upper = Inf, finite = FALSE) {
  isTRUE(checkNumber(x, na.ok, lower, upper, finite))
}

#' @rdname checkNumber
#' @export
test_number = testNumber

#' @rdname checkNumber
#' @template expect
#' @export
expect_number = function(x, na.ok = FALSE, lower = -Inf, upper = Inf, finite = FALSE, info = NULL, label = NULL) {
  res = checkNumber(x, na.ok, lower, upper, finite)
  makeExpectation(res, info = info, label = vname(x, label))
}


### auto-generated functions for checkNumeric ############################################################################

#' @rdname checkNumeric
#' @export
assertNumeric = function(x, lower = -Inf, upper = Inf, finite = FALSE, any.missing = TRUE, all.missing = TRUE, len = NULL, min.len = NULL, max.len = NULL, unique = FALSE, names = NULL, add = NULL, .var.name) {
  res = checkNumeric(x, lower, upper, finite, any.missing, all.missing, len, min.len, max.len, unique, names)
  makeAssertion(x, res, vname(x, .var.name), add)
}

#' @rdname checkNumeric
#' @export
assert_numeric = assertNumeric

#' @rdname checkNumeric
#' @export
testNumeric = function(x, lower = -Inf, upper = Inf, finite = FALSE, any.missing = TRUE, all.missing = TRUE, len = NULL, min.len = NULL, max.len = NULL, unique = FALSE, names = NULL) {
  isTRUE(checkNumeric(x, lower, upper, finite, any.missing, all.missing, len, min.len, max.len, unique, names))
}

#' @rdname checkNumeric
#' @export
test_numeric = testNumeric

#' @rdname checkNumeric
#' @template expect
#' @export
expect_numeric = function(x, lower = -Inf, upper = Inf, finite = FALSE, any.missing = TRUE, all.missing = TRUE, len = NULL, min.len = NULL, max.len = NULL, unique = FALSE, names = NULL, info = NULL, label = NULL) {
  res = checkNumeric(x, lower, upper, finite, any.missing, all.missing, len, min.len, max.len, unique, names)
  makeExpectation(res, info = info, label = vname(x, label))
}


### auto-generated functions for checkPathForOutput ############################################################################

#' @rdname checkPathForOutput
#' @export
assertPathForOutput = function(x, overwrite = FALSE, add = NULL, .var.name) {
  res = checkPathForOutput(x, overwrite)
  makeAssertion(x, res, vname(x, .var.name), add)
}

#' @rdname checkPathForOutput
#' @export
assert_path_for_output = assertPathForOutput

#' @rdname checkPathForOutput
#' @export
testPathForOutput = function(x, overwrite = FALSE) {
  isTRUE(checkPathForOutput(x, overwrite))
}

#' @rdname checkPathForOutput
#' @export
test_path_for_output = testPathForOutput

#' @rdname checkPathForOutput
#' @template expect
#' @export
expect_path_for_output = function(x, overwrite = FALSE, info = NULL, label = NULL) {
  res = checkPathForOutput(x, overwrite)
  makeExpectation(res, info = info, label = vname(x, label))
}


### auto-generated functions for checkScalar ############################################################################

#' @rdname checkScalar
#' @export
assertScalar = function(x, na.ok = FALSE, add = NULL, .var.name) {
  res = checkScalar(x, na.ok)
  makeAssertion(x, res, vname(x, .var.name), add)
}

#' @rdname checkScalar
#' @export
assert_scalar = assertScalar

#' @rdname checkScalar
#' @export
testScalar = function(x, na.ok = FALSE) {
  isTRUE(checkScalar(x, na.ok))
}

#' @rdname checkScalar
#' @export
test_scalar = testScalar

#' @rdname checkScalar
#' @template expect
#' @export
expect_scalar = function(x, na.ok = FALSE, info = NULL, label = NULL) {
  res = checkScalar(x, na.ok)
  makeExpectation(res, info = info, label = vname(x, label))
}


### auto-generated functions for checkScalarNA ############################################################################

#' @rdname checkScalarNA
#' @export
assertScalarNA = function(x, add = NULL, .var.name) {
  res = checkScalarNA(x)
  makeAssertion(x, res, vname(x, .var.name), add)
}

#' @rdname checkScalarNA
#' @export
assert_scalar_na = assertScalarNA

#' @rdname checkScalarNA
#' @export
testScalarNA = function(x) {
  isTRUE(checkScalarNA(x))
}

#' @rdname checkScalarNA
#' @export
test_scalar_na = testScalarNA

#' @rdname checkScalarNA
#' @template expect
#' @export
expect_scalar_na = function(x, info = NULL, label = NULL) {
  res = checkScalarNA(x)
  makeExpectation(res, info = info, label = vname(x, label))
}


### auto-generated functions for checkSetEqual ############################################################################

#' @rdname checkSetEqual
#' @export
assertSetEqual = function(x, y, ordered = FALSE, add = NULL, .var.name) {
  res = checkSetEqual(x, y, ordered)
  makeAssertion(x, res, vname(x, .var.name), add)
}

#' @rdname checkSetEqual
#' @export
assert_set_equal = assertSetEqual

#' @rdname checkSetEqual
#' @export
testSetEqual = function(x, y, ordered = FALSE) {
  isTRUE(checkSetEqual(x, y, ordered))
}

#' @rdname checkSetEqual
#' @export
test_set_equal = testSetEqual

#' @rdname checkSetEqual
#' @template expect
#' @export
expect_set_equal = function(x, y, ordered = FALSE, info = NULL, label = NULL) {
  res = checkSetEqual(x, y, ordered)
  makeExpectation(res, info = info, label = vname(x, label))
}


### auto-generated functions for checkString ############################################################################

#' @rdname checkString
#' @export
assertString = function(x, na.ok = FALSE, add = NULL, .var.name) {
  res = checkString(x, na.ok)
  makeAssertion(x, res, vname(x, .var.name), add)
}

#' @rdname checkString
#' @export
assert_string = assertString

#' @rdname checkString
#' @export
testString = function(x, na.ok = FALSE) {
  isTRUE(checkString(x, na.ok))
}

#' @rdname checkString
#' @export
test_string = testString

#' @rdname checkString
#' @template expect
#' @export
expect_string = function(x, na.ok = FALSE, info = NULL, label = NULL) {
  res = checkString(x, na.ok)
  makeExpectation(res, info = info, label = vname(x, label))
}


### auto-generated functions for checkSubset ############################################################################

#' @rdname checkSubset
#' @export
assertSubset = function(x, choices, empty.ok = TRUE, add = NULL, .var.name) {
  res = checkSubset(x, choices, empty.ok)
  makeAssertion(x, res, vname(x, .var.name), add)
}

#' @rdname checkSubset
#' @export
assert_subset = assertSubset

#' @rdname checkSubset
#' @export
testSubset = function(x, choices, empty.ok = TRUE) {
  isTRUE(checkSubset(x, choices, empty.ok))
}

#' @rdname checkSubset
#' @export
test_subset = testSubset

#' @rdname checkSubset
#' @template expect
#' @export
expect_subset = function(x, choices, empty.ok = TRUE, info = NULL, label = NULL) {
  res = checkSubset(x, choices, empty.ok)
  makeExpectation(res, info = info, label = vname(x, label))
}


### auto-generated functions for checkVector ############################################################################

#' @rdname checkVector
#' @export
assertVector = function(x, strict = FALSE, any.missing = TRUE, all.missing = TRUE, len = NULL, min.len = NULL, max.len = NULL, unique = FALSE, names = NULL, add = NULL, .var.name) {
  res = checkVector(x, strict, any.missing, all.missing, len, min.len, max.len, unique, names)
  makeAssertion(x, res, vname(x, .var.name), add)
}

#' @rdname checkVector
#' @export
assert_vector = assertVector

#' @rdname checkVector
#' @export
testVector = function(x, strict = FALSE, any.missing = TRUE, all.missing = TRUE, len = NULL, min.len = NULL, max.len = NULL, unique = FALSE, names = NULL) {
  isTRUE(checkVector(x, strict, any.missing, all.missing, len, min.len, max.len, unique, names))
}

#' @rdname checkVector
#' @export
test_vector = testVector

#' @rdname checkVector
#' @template expect
#' @export
expect_vector = function(x, strict = FALSE, any.missing = TRUE, all.missing = TRUE, len = NULL, min.len = NULL, max.len = NULL, unique = FALSE, names = NULL, info = NULL, label = NULL) {
  res = checkVector(x, strict, any.missing, all.missing, len, min.len, max.len, unique, names)
  makeExpectation(res, info = info, label = vname(x, label))
}


