#' Check existence and access rights of files
#'
#' @templateVar fn File
#' @template x
#' @inheritParams checkAccess
#' @param extension [\code{character}]\cr
#'  Vector of allowed file extensions, matched case insensitive.
#' @template checker
#' @family filesystem
#' @export
#' @examples
#' # Check if R's COPYING file is readable
#' testFile(file.path(R.home(), "COPYING"), access = "r")
#'
#' # Check if R's COPYING file is readable and writable
#' testFile(file.path(R.home(), "COPYING"), access = "rw")
checkFile = function(x, access = "", extension = NULL) {
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
    pos = regexpr("\\.([[:alnum:]]+)$", x)
    ext = ifelse(pos > -1L, tolower(substring(x, pos + 1L)), "")
    if (any(ext %nin% tolower(extension)))
      return(sprintf("File extension must be in {'%s'}", paste0(extension, collapse = "','")))
  }
  return(TRUE)
}

#' @export
#' @include makeAssertion.R
#' @template assert
#' @rdname checkFile
assertFile = makeAssertionFunction(checkFile)

#' @export
#' @rdname checkFile
assert_file = assertFile

#' @export
#' @include makeTest.R
#' @rdname checkFile
testFile = makeTestFunction(checkFile)

#' @export
#' @rdname checkFile
test_file = testFile

#' @export
#' @include makeExpectation.R
#' @template expect
#' @rdname checkFile
expect_file = makeExpectationFunction(checkFile)
