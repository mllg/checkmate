#' Checks if an argument is a string
#'
#' A string a a single character value.
#'
#' @templateVar id String
#' @template testfuns
#' @param na.ok [\code{logical(1)}]\cr
#'  Are missing values allowed? Default is \code{FALSE}.
#' @param ... [ANY]\cr
#'  Additional parameters used in a call of \code{\link{isCharacter}}
#'  or \code{\link{assertCharacter}}.
#' @export
assertString = function(x, na.ok = FALSE, ..., .var.name) {
  amsg(testString(x, na.ok, ...), vname(x, .var.name))
}

#' @rdname assertString
#' @export
isString = function(x, na.ok = FALSE, ...) {
  isTRUE(testString(x, na.ok, ...))
}

#' @rdname assertString
#' @export
asString = function(x, na.ok = FALSE, ..., .var.name) {
  assertString(x, na.ok, ..., .var.name = vname(x, .var.name))
  x
}

testString = function(x, na.ok = FALSE, ...) {
  qassert(na.ok, "B1")
  if(length(x) != 1L || !is.character(x))
    return("'%s' must be a scalar string")
  if (!na.ok && is.na(x))
    return("'%s' may not be NA")
  testCharacterProps(x, ...)
}
