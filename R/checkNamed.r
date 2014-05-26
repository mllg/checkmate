#' Check if an argument is named
#'
#' @templateVar fn Named
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
#'  testNamed(x, "unnamed")
#'  names(x) = letters[1:3]
#'  testNamed(x, "unique")
checkNamed = function(x, type = "named") {
  if (length(x) == 0L)
    return(TRUE)
  return(checkNames(names(x), type))
}

checkNames = function(nn, type = "named") {
  type = match.arg(type, c("any", "unnamed", "named", "unique", "strict"))
  if (type == "any")
    return(TRUE)
  if (type == "unnamed") {
    if (!is.null(nn))
      return("Must be unnamed")
    return(TRUE)
  }
  if (is.null(nn) || anyMissing(nn) || !all(nzchar(nn)))
    return("Must be named")
  if (type %in% c("unique", "strict")) {
    if (anyDuplicated(nn) > 0L)
      return("Contains duplicated names")
    if (type == "strict" && any(nn != make.names(nn) | grepl("^\\.\\.[0-9]$", nn)))
      return("Names not compatible with R's variable naming rules")
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
  isTRUE(checkNamed(x, type))
}
