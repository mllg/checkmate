#' @param x [\code{ANY}]\cr
#'  Object to check.
#' @param .var.name [\code{logical(1)}]\cr
#'  Argument name to print in error message. If missing,
#'  the name of \code{x} will be retrieved via \code{\link[base]{substitute}}.
#' @return Depending on the prefix:
#'  \describe{
#'   \item{\code{is<%= id %>}:}{Single logical value indicating success.}
#'   \item{\code{assert<%= id %>}:}{\code{TRUE} on success. An exception is thrown otherwise.}
#'   \item{\code{as<%= id %>}:}{The (possibly converted) object itself on success. An exception is thrown otherwise.}
#' }
