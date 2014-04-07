#' Checks if an argument is a flag
#'
#' A flag a a single logical value which is not missing.
#'
#' @param x [\code{ANY}]\cr
#'  Object to check.
#' @param na.ok [\code{logical(1)}]\cr
#'  Are missing values allowed? Default is \code{FALSE}.
#' @param .var.name [\code{logical(1)}]\cr
#'  Argument name to print in error message. If missing,
#'  the name of \code{x} will be retrieved via \code{\link[base]{substitute}}.
#' @return [\code{logical(1)}] Returns \code{TRUE} on success.
#'  Throws an exception on failure for assertion.
#' @export
assertFlag = function(x, na.ok = FALSE, .var.name) {
  amsg(testFlag(na.ok, FALSE), "na.ok")
  amsg(testFlag(x, na.ok), vname(x, .var.name))
}

#' @rdname assertFlag
#' @export
isFlag = function(x, na.ok = FALSE) {
  amsg(testFlag(na.ok, FALSE), "na.ok")
  isTRUE(testFlag(x, na.ok))
}

#' @rdname assertFlag
#' @export
asFlag = function(x, na.ok = FALSE, .var.name) {
  assertFlag(x, na.ok = na.ok, .var.name = vname(x, .var.name))
  x
}

testFlag = function(x, na.ok = FALSE) {
  if(length(x) != 1L || !is.logical(x) || (!na.ok && is.na(x)))
    return("'%s' must be a flag")
  return(TRUE)
}
