#' @param x [ANY]\cr
#'  Object to check.
#' @param .var.name [character(1)]\cr
#'  Name for \code{x}. Defaults to a heuristic to determine
#'  the name using \code{\link[base]{deparse}} and \code{\link[base]{substitute}}.
#' @return Depending on the function prefix:
#'  If the check is successfull, all functions return \code{TRUE}.
#'  If the check is not successfull, \code{assert<%= fn %>} throws an error message,
#'  \code{test<%= fn %>} returns \code{FALSE} and \code{check<%= fn %>} returns
#'  a \code{\link[base]{sprintf}} suitable message template with a placeholder
#'  for the variable name.
