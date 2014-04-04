#' Check or assert that an argument is named
#'
#' @param x [\code{ANY}]\cr
#'  Object to check.
#' @param type [character]\cr
#'  Select the checks to perform.
#'  \dQuote{off} performs no check at all.
#'  \dQuote{unnamed} checks \code{x} to be unnamed.
#'  \dQuote{existing} (default) checks \code{x} to be named, this includes names to be not \code{NA} or emtpy (\code{""}).
#'  \dQuote{unique} checks tests for non-duplicated names and \code{strict} tests the names to comply to R's variable naming rules.
#'  These later three arguments can be mixed together.
#'  Note that for zero-length \code{x} every name check is \code{TRUE}.
#' @param .var.name [\code{logical(1)}]\cr
#'  Argument name to print in error message. If missing,
#'  the name of \code{x} will be retrieved via \code{\link[base]{substitute}}.
#' @return [\code{logical(1)}] Returns \code{TRUE} on success.
#'  Throws an exception on failure for assertion.
#' @export
assertNamed = function(x, type = "existing", .var.name) {
  amsg(testNamed(x, type), vname(x, .var.name))
}

#' @rdname assertNamed
#' @export
checkNamed = function(x, type = "existing") {
  isTRUE(testNamed(x, type))
}

testNamed = function(x, type = "existing") {
  if (length(x) == 0L)
    return(TRUE)
  return(testNames(names(x), type))
}

testNames = function(nn, type = "existing") {
  type = match.arg(type, c("off", "existing", "unique", "strict", "unnamed"), several.ok = TRUE)

  if ("any" %in% type) {
    if (length(type) > 1L)
      stop("You cannot mix 'off' in argument 'type' with other checks")
    return(TRUE)
  }

  if ("unnamed" %in% type) {
    if (!is.null(nn))
      return("'%s' must be unnamed")
    if (length(type) > 1L)
      stop("You cannot mix 'unnamed' in argument 'type' with other checks")
    return(TRUE)
  }

  if ("existing" %in% type) {
    if (is.null(nn) || anyMissing(nn) || !all(nzchar(nn)))
      return("'%s' must be named")
  }

  if ("unique" %in% type) {
    if (anyDuplicated(nn) > 0L)
      return("'%s' contains duplicated names")
  }

  if ("strict" %in% type) {
    if(any(nn != make.names(nn) | grepl("^\\.\\.[0-9]$", nn)))
      return("Names of '%s' are not compatible with R's variable naming rules")
  }

  return(TRUE)
}
