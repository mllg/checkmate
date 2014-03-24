testFlag = function(x) {
  if(length(x) != 1L || !is.logical(x) || is.na(x))
    return("'%s' must be a flag")
  return(TRUE)
}

#' Checks if an argument is a flag
#'
#' A flag a a single logical value which is not missing.
#'
#' @param x [\code{ANY}]\cr
#'  Object to check.
#' @return [\code{logical(1)}] Returns \code{TRUE} on success.
#'  Throws an exception on failure for assertion.
#' @export
checkFlag = function(x) {
  isTRUE(testFlag(x))
}

#' @rdname checkFlag
#' @export
assertFlag = function(x) {
  amsg(testFlag(x), dps(x))
}
