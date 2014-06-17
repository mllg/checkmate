#' @title Check file path for later output
#'
#' @description
#' Check whether a file path can later be safely used to create a file and write to it.
#'
#' This is checked:
#' \itemize{
#'  \item{Does \code{dirname(x)} exist?}
#'  \item{Does no file under path \code{x)} exist?}
#'  \item{Is \code{dirname(x)} writeable?}
#' }
#'
#' A string without slashes is interpreted as a file in the current working directory.
#'
#' @templateVar fn PathForOutput
#' @template checker
#' @family filesystem
#' @export
#' @examples
#' # Can we create a file in the tempdir?
#' testPathForOutput(file.path(tempdir(), "process.log"))
checkPathForOutput = function(x) {
  if (!qtest(x, "S+"))
    return("No path provided")
  x = normalizePath(x, mustWork = FALSE)

  dn = dirname(x)
  isdir = file.info(dn)$isdir
  w = wf(!file.exists(dn) || is.na(isdir))
  if (length(w) > 0L)
    return(sprintf("Path to file (dirname) does not exist: '%s' of '%s'", dn[w], x[w]))
  w = wf(file.exists(x))
  if (length(w) > 0L)
    return(sprintf("File at path already exists: '%s'", x[w]))
  return(checkAccess(dn, "w"))
}

#' @rdname checkPathForOutput
#' @export
assertPathForOutput = function(x, .var.name) {
  res = checkPathForOutput(x)
  makeAssertion(res, vname(x, .var.name))
}

#' @rdname checkPathForOutput
#' @export
testPathForOutput = function(x) {
  isTRUE(checkPathForOutput(x))
}
