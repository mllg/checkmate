#' @title Check if a path is suited for creating an output file
#'
#' @description
#' Check if a file path can be used safely to create a file and write to it.
#'
#' This is checked:
#' \itemize{
#'  \item{Does \code{dirname(x)} exist?}
#'  \item{Does no file under path \code{x} exist?}
#'  \item{Is \code{dirname(x)} writable?}
#' }
#' Paths are relative to the current working directory.
#'
#' @templateVar fn PathForOutput
#' @template x
#' @param overwrite [\code{logical(1)}]\cr
#'  If \code{TRUE}, an existing file in place is allowed if it
#'  it is both readable and writable.
#'  Default is \code{FALSE}.
#' @param extension [\code{character(1)}]\cr
#'  Extension of the file, e.g. \dQuote{txt} or \dQuote{tar.gz}.
#' @template checker
#' @family filesystem
#' @export
#' @examples
#' # Can we create a file in the tempdir?
#' testPathForOutput(file.path(tempdir(), "process.log"))
checkPathForOutput = function(x, overwrite = FALSE, extension = NULL) {
  if (!qtest(x, "S+"))
    return("No path provided")
  qassert(overwrite, "B1")

  x = normalizePath(x, mustWork = FALSE)
  dn = dirname(x)

  w = wf(!dir.exists(dn))
  if (length(w) > 0L)
    return(sprintf("Path to file (dirname) does not exist: '%s' of '%s'", dn[w], x[w]))

  w = which(file.exists(x))
  if (length(w) > 0L) {
    if (overwrite)
      return(checkAccess(dn, "w") %and% checkAccess(x[w], "rw"))
    return(sprintf("File at path already exists: '%s'", x[w]))
  }

  if (!is.null(extension)) {
    qassert(extension, "S1")
    if (!endsWith(x, paste0(".", extension)))
      return(sprintf("File must have extension '.%s'", extension))
  }
  return(checkAccess(dn, "w"))
}

#' @export
#' @rdname checkPathForOutput
check_path_for_output = checkPathForOutput

#' @export
#' @include makeAssertion.R
#' @template assert
#' @rdname checkPathForOutput
assertPathForOutput = makeAssertionFunction(checkPathForOutput, use.namespace = FALSE)

#' @export
#' @rdname checkPathForOutput
assert_path_for_output = assertPathForOutput

#' @export
#' @include makeTest.R
#' @rdname checkPathForOutput
testPathForOutput = makeTestFunction(checkPathForOutput)

#' @export
#' @rdname checkPathForOutput
test_path_for_output = testPathForOutput

#' @export
#' @include makeExpectation.R
#' @template expect
#' @rdname checkPathForOutput
expect_path_for_output = makeExpectationFunction(checkPathForOutput, use.namespace = FALSE)
