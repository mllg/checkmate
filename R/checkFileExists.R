#' Check existence and access rights of files
#'
#' @note
#' The functions without the suffix \dQuote{exists} are deprecated and will be removed
#' from the package in a future version due to name clashes.
#' \code{test_file} has been unexported already.
#'
#' @templateVar fn FileExists
#' @template x
#' @inheritParams checkAccess
#' @param extension [\code{character}]\cr
#'  Vector of allowed file extensions, matched case insensitive.
#' @template checker
#' @family filesystem
#' @export
#' @examples
#' # Check if R's COPYING file is readable
#' testFileExists(file.path(R.home(), "COPYING"), access = "r")
#'
#' # Check if R's COPYING file is readable and writable
#' testFileExists(file.path(R.home(), "COPYING"), access = "rw")
checkFileExists = function(x, access = "", extension = NULL) {
  if (!qtest(x, "S+"))
    return("No file provided")

  w = wf(dir.exists(x))
  if (length(w) > 0L)
    return(sprintf("File expected, but directory in place: '%s'", x[w]))

  w = wf(!file.exists(x))
  if (length(w) > 0L)
    return(sprintf("File does not exist: '%s'", x[w]))

  checkAccess(x, access) %and% checkFileExtension(x, extension)
}

checkFileExtension = function(x, extension = NULL) {
  if (!is.null(extension)) {
    qassert(extension, "S+")
    ii = Reduce(`|`, lapply(tolower(extension), endsWith, x = tolower(x)))
    if (!all(ii))
      return(sprintf(
        "File extension must be in {'%s'} (case insensitive), but file name is '%s'",
        paste0(extension, collapse = "','"), x[wf(!ii)]
      ))
  }
  return(TRUE)
}

#' @export
#' @rdname checkFileExists
check_file_exists = checkFileExists

#' @export
#' @include makeAssertion.R
#' @template assert
#' @rdname checkFileExists
assertFileExists = makeAssertionFunction(checkFileExists, use.namespace = FALSE)

#' @export
#' @rdname checkFileExists
assert_file_exists = assertFileExists

#' @export
#' @include makeTest.R
#' @rdname checkFileExists
testFileExists = makeTestFunction(checkFileExists)

#' @export
#' @rdname checkFileExists
test_file_exists = testFileExists

#' @export
#' @include makeExpectation.R
#' @template expect
#' @rdname checkFileExists
expect_file_exists = makeExpectationFunction(checkFileExists, use.namespace = FALSE)

#' @export
#' @rdname checkFileExists
checkFile = checkFileExists

#' @export
#' @rdname checkFileExists
assertFile = assertFileExists

#' @export
#' @rdname checkFileExists
assert_file = assert_file_exists

#' @export
#' @rdname checkFileExists
testFile = testFileExists

#' @export
#' @rdname checkFileExists
expect_file = expect_file_exists
