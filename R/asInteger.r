#' Safely converts an object to an integer
#'
#' Supported are logical, interger and numeric types.
#' Unlike \code{\link[base]{as.integer}}, an exception is thrown if
#' \code{x} cannot be converted safely (without generating \code{NA}s).
#'
#' @param x [\code{ANY}]\cr
#'  Object to convert.
#' @param ... [ANY]\cr
#'  Additional parameters used in a call of \code{\link{assertVector}}.
#' @param .var.name [\code{logical(1)}]\cr
#'  Argument name to print in error message. If missing,
#'  the name of \code{x} will be retrieved via \code{\link[base]{substitute}}.
#' @return [\code{integer}] Returns the converted object on success.
#' @export
asInteger = function(x, ..., .var.name) {
  if (!checkIntegerish(x))
    amsg("'%s' cannot be converted to an integer", vname(x, .var.name))
  amsg(testVectorProps(x, ...), vname(x, .var.name))
  as.integer(x)
}
