#' Check for existence and access rights of directories
#'
#' @note
#' The functions without the suffix \dQuote{exists} are deprecated and will be removed
#' from the package in a future version due to name clashes.
#'
#' @templateVar fn DirectoryExists
#' @template x
#' @inheritParams checkAccess
#' @inheritParams checkFile
#' @template checker
#' @family filesystem
#' @export
#' @examples
#' # Is R's home directory readable?
#' testDirectory(R.home(), "r")
#'
#' # Is R's home directory readable and writable?
#' testDirectory(R.home(), "rw")
checkDirectoryExists = function(x, access = "") {
  if (!qtest(x, "S+"))
    return("No directory provided")

  w = wf(!file.exists(x))
  if (length(w) > 0L)
    return(sprintf("Directory '%s' does not exists", x[w]))

  w = wf(!dir.exists(x))
  if (length(w) > 0L)
    return(sprintf("Directory expected, but file in place: '%s'", x[w]))

  checkAccess(x, access)
}

#' @export
#' @rdname checkDirectoryExists
check_directory_exists = checkDirectoryExists

#' @export
#' @include makeAssertion.R
#' @template assert
#' @rdname checkDirectoryExists
assertDirectoryExists = makeAssertionFunction(checkDirectoryExists)

#' @export
#' @rdname checkDirectoryExists
assert_directory_exists = assertDirectoryExists

#' @export
#' @include makeTest.R
#' @rdname checkDirectoryExists
testDirectoryExists = makeTestFunction(checkDirectoryExists)

#' @export
#' @rdname checkDirectoryExists
test_directory_exists = testDirectoryExists

#' @export
#' @rdname checkDirectoryExists
expect_directory_exists = makeExpectationFunction(checkDirectoryExists)

#' @export
#' @rdname checkDirectoryExists
checkDirectory = checkDirectoryExists

#' @export
#' @rdname checkDirectoryExists
assertDirectory = assertDirectoryExists

#' @export
#' @rdname checkDirectoryExists
assert_directory = assert_directory_exists

#' @export
#' @rdname checkDirectoryExists
testDirectory = testDirectoryExists

#' @export
#' @rdname checkDirectoryExists
test_directory = test_directory_exists

#' @export
#' @rdname checkDirectoryExists
expect_directory = expect_directory_exists
