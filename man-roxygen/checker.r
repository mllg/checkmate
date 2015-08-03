#' @param add [\code{AssertCollection}]\cr
#'  Collection to store assertions. See \code{\link{AssertCollection}}.
#' @param .var.name [character(1)]\cr
#'  Name for \code{x}. Defaults to a heuristic to determine
#'  the name using \code{\link[base]{deparse}} and \code{\link[base]{substitute}}.
#' @return Depending on the function prefix:
#'  If the check is successful, all functions return \code{TRUE}.
#'  If the check is not successful, \code{assert<%= fn %>} throws an error message,
#'  \code{test<%= fn %>} returns \code{FALSE}, \code{check<%= fn %>} returns
#'  a string with the error message. The function \code{expect<%= killCamel(fn) %>} will
#'  return an \code{\link[testthat]{expectation}}.
