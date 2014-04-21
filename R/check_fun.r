#' Check if an argument to is a function
#'
#' @template checker
#' @param args [\code{character}]\cr
#'  Expected formal arguments.
#' @param ordered [\code{logical(1)}]\cr
#'  Flag whether the arguments provided in \code{args} must be the first
#'  arguments of the function and occur in the given order.
#'  Default is \code{FALSE}.
#' @family checker
#' @export
#' @examples
#'  test(median, "fun", args = c("x", "na.rm"))
check_fun = function(x, args, ordered = FALSE) {
  qassert(ordered, "B1")
  x = try(match.fun(x), silent=TRUE)
  if (inherits(x, "try-error"))
    return("Function '%s' not found")

  if (!missing(args)) {
    qassert(args, "S")
    fargs = names(formals(x))
    if (is.null(fargs))
      fargs = character(0L)

    if (ordered) {
      if (any(args != head(fargs, length(args)))) {
        return(sprintf("Function '%%s' must have first formal arguments (ordered): %s", collapse(args)))
      }
    } else {
      tmp = setdiff(args, fargs)
      if (length(tmp))
        return(sprintf("Function '%%s' is missing formal arguments: %s", collapse(tmp)))
    }
  }
  return(TRUE)
}
