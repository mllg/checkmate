#' @title Check file path for later output
#'
#' @description
#' Check whether a file path can later be safely used to create a file and write to it.
#'
#' This is checked:
#' \itemize{
#' \item{Does \code{dirname(x)} exist?}
#' \item{Does no file under path \code{x)} exist?}
#' \item{Is \code{dirname(x)} writeable?}
#' }
#'
#' A string without slashes is interpreted as a file in the current working directory.
#'
#' @templateVar fn PathForOutput
#' @template checker
#' @family filesystem
#' @export
checkPathForOutput = function(x) {
  ch = checkString(x)
  if (!isTRUE(ch))
    return(ch)

  dn = dirname(x)
  isdir = file.info(dn)$isdir
  if (!file.exists(dn) || is.na(isdir))
    return(sprintf("Path to file (dirname) does not exist: '%s' of '%s'", dn, x))
  if (file.exists(x))
    return(sprintf("File at path already exists: '%s'", x))
  return(checkAccess(dn, "w"))
}

#' @export
#' @rdname checkFile
assertPathForOutput = function(x, .var.name) {
  makeAssertion(checkPathForOutput(x), vname(x, .var.name))
}

#' @rdname checkFile
#' @export
testPathForOutput = function(x) {
  isTRUE(checkPathForOutput(x))
}

