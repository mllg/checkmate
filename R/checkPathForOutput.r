#' @title Check if a path is suited for creating an output file
#'
#' @description
#' Check if a file path can be safely be used to create a file and write to it.
#'
#' This is checked:
#' \itemize{
#'  \item{Does \code{dirname(x)} exist?}
#'  \item{Does no file under path \code{x} exist?}
#'  \item{Is \code{dirname(x)} writeable?}
#' }
#' Paths are relative to the current working directory.
#'
#' @templateVar fn PathForOutput
#' @template x
#' @param overwrite [\code{logical(1)}]\cr
#'  If \code{TRUE}, an existing file in place is allowed if it
#'  it is both readable and writeable.
#'  Default is \code{FALSE}.
#' @template checker
#' @family filesystem
#' @export
#' @examples
#' # Can we create a file in the tempdir?
#' testPathForOutput(file.path(tempdir(), "process.log"))
checkPathForOutput = function(x, overwrite = FALSE) {
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
  return(checkAccess(dn, "w"))
}

#' @export
#' @include makeAssertion.r
#' @template assert
#' @rdname checkPathForOutput
assertPathForOutput = makeAssertionFunction(checkPathForOutput)

#' @export
#' @rdname checkPathForOutput
assert_path_for_output = assertPathForOutput

#' @export
#' @include makeTest.r
#' @rdname checkPathForOutput
testPathForOutput = makeTestFunction(checkPathForOutput)

#' @export
#' @rdname checkPathForOutput
test_path_for_output = testPathForOutput

#' @export
#' @include makeExpectation.r
#' @template expect
#' @rdname checkPathForOutput
expect_path_for_output = makeExpectationFunction(checkPathForOutput)
