#' Matches and checks a function's signature
#'
#' @param fun [\code{character} or \code{function}]\cr
#'  Function to match or check.
#' @param args [\code{character}]\cr
#'  Expected formal arguments.
#' @param ordered [\code{logical(1)}]\cr
#'  Flag whether the arguments provided in \code{args} must be the first
#'  arguments of the function and occur in the given order.
#'  Default is \code{FALSE}.
#' @return [\code{logical(1)}] Returns \code{TRUE} if at least one element of \code{x} is missing (see details).
#' @useDynLib checkmate c_any_missing
#' @export
assertFun = function(fun, args, ordered = FALSE) {
  fun = match.fun(fun)

  if (!missing(args)) {
    qassert(args, "S")
    qassert(ordered, "B1")
    fargs = names(formals(fun))
    if (is.null(fargs))
      fargs = character(0L)

    if (ordered) {
      if (any(args != head(fargs, length(args)))) {
        stop("Function must have first formal arguments (ordered): ", paste(args, collapse=","))
      }
    } else {
      tmp = setdiff(args, fargs)
      if (length(tmp))
        stop("Function is missing formal arguments: ", paste(tmp, collapse=","))
    }
  }
  fun
}
