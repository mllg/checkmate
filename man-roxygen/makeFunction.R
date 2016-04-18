#' @param check.fun [\code{function}]\cr
#'  Function which checks the input. Must return \code{TRUE} on success and a string with the error message otherwise.
#' @param c.fun [\code{character(1)}]\cr
#'  If not \code{NULL}, instead of calling the function \code{check.fun}, use \code{.Call} to call a C function \dQuote{c.fun} with the identical
#'  set of parameters. The C function must be registered as a native symbol, see \code{\link[base]{.Call}}.
#'  Useful if \code{check.fun} is just a simple wrapper.
#' @param env [\code{environment}]\cr
#'  The environment of the created function. Default is the \code{\link[base]{parent.frame}}.
