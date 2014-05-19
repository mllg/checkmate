#' Check if an argument is named
#'
#' @template checker
#' @param type [character(1)]\cr
#'  Select the check(s) to perform.
#'  \dQuote{unnamed} checks \code{x} to be unnamed.
#'  \dQuote{named} (default) checks \code{x} to be named, this includes names to be not \code{NA} or emtpy (\code{""}).
#'  \dQuote{unique} additionally tests for non-duplicated names and \code{strict} tests the names to comply to R's variable naming rules on top of \dQuote{unique}.
#'  Note that for zero-length \code{x} every name check evalutes to \code{TRUE}.
#' @export
#' @examples
#'  x = 1:3
#'  test(x, "named", "unnamed")
#'  names(x) = letters[1:3]
#'  test(x, "named", "unique")
checkNamed = function(x, type = "named") {
  if (length(x) == 0L)
    return(TRUE)
  return(checkNames(names(x), type))
}

checkNames = function(nn, type = "named") {
  type = match.arg(type, c("unnamed", "named", "unique", "strict"))

  if (type == "unnamed") {
    if (!is.null(nn))
      return("'%s' must be unnamed")
    return(TRUE)
  } else if (is.null(nn) || anyMissing(nn) || !all(nzchar(nn))) {
    return("'%s' must be named")
  }

  if (type %in% c("unique", "strict")) {
    if (anyDuplicated(nn) > 0L)
      return("'%s' contains duplicated names")
    if (type == "strict" && any(nn != make.names(nn) | grepl("^\\.\\.[0-9]$", nn)))
      return("Names of '%s' are not compatible with R's variable naming rules")
  }

  return(TRUE)
}


#' @rdname checkNamed
#' @export
assertNamed = function(x, type = "named", .var.name) {
  makeAssertion(checkNamed(x, type), vname(x, .var.name))
}

#' @rdname checkNamed
#' @export
testNamed = function(x, type = "named") {
  makeTest(checkNamed(x, type))
}
