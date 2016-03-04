#' Check for existence and access rights of directories
#'
#' @templateVar fn Directory
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
checkDirectory = function(x, access = "") {
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
#' @include makeAssertion.r
#' @template assert
#' @rdname checkDirectory
assertDirectory = makeAssertionFunction(checkDirectory)

#' @export
#' @rdname checkDirectory
assert_directory = assertDirectory

#' @export
#' @include makeTest.r
#' @rdname checkDirectory
testDirectory = makeTestFunction(checkDirectory)

#' @export
#' @rdname checkDirectory
test_directory = testDirectory

#' @export
#' @include makeExpectation.r
#' @template expect
#' @rdname checkDirectory
expect_directory = makeExpectationFunction(checkDirectory)
