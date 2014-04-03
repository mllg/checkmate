testNamed = function(x, dups.ok, strict) {
  assertFlag(dups.ok)
  nn = names(x)
  if (is.null(nn) || anyMissing(nn) || !all(nzchar(nn)))
    return("'%s' must be named")
  if ((!dups.ok || strict) && anyDuplicated(nn) > 0L)
    return("'%s' contains duplicted names")
  if (!strict && (any(x != make.names(x)) | grepl("^\\.\\.[0-9]$", x)))
    return("Names of '%s' are not compatible with R's variable naming rules")
  return(TRUE)
}

#' Check or assert that an argument is named
#'
#' @param x [ANY]\cr
#'  Object to check.
#' @param dups.ok [logical(1)]\cr
#'  Are duplicated names okay?
#'  Default is \code{TRUE}.
#' @param strict [logical(1)]\cr
#'  Enables a check for compability with R's variable naming rules.
#'  Default is \code{FALSE}.
#' @return [\code{logical(1)}] Returns \code{TRUE} on success.
#'  Throws an exception on failure for assertion.
#' @export
checkNamed = function(x, dups.ok=TRUE, strict=FALSE) {
  isTRUE(testNamed(x, dups.ok, strict))
}

#' @rdname checkNamed
#' @export
assertNamed = function(x, dups.ok=TRUE, strict=FALSE) {
  amsg(testNamed(x, dups.ok, strict), dps(x))
}
