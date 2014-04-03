testFlag = function(x, na.ok = FALSE) {
  if(length(x) != 1L || !is.logical(x) || (!na.ok && is.na(x)))
    return("'%s' must be a flag")
  return(TRUE)
}

#' Checks if an argument is a flag
#'
#' A flag a a single logical value which is not missing.
#'
#' @param x [\code{ANY}]\cr
#'  Object to check.
#' @param na.ok [\code{logical(1)}]\cr
#'  Are missing values allowed? Default is \code{FALSE}.
#' @return [\code{logical(1)}] Returns \code{TRUE} on success.
#'  Throws an exception on failure for assertion.
#' @export
checkFlag = function(x, na.ok = FALSE) {
  amsg(testFlag(na.ok, FALSE), "na.ok")
  isTRUE(testFlag(x, na.ok))
}

#' @rdname checkFlag
#' @export
assertFlag = function(x, na.ok = FALSE) {
  amsg(testFlag(na.ok, FALSE), "na.ok")
  amsg(testFlag(x, na.ok), dps(x))
}
