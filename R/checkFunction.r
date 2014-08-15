#' Check if an argument is a function
#'
#' @templateVar fn Function
#' @template checker
#' @param args [\code{character}]\cr
#'  Expected formal arguments. Checks that a function has no arguments if
#'  set to \code{character(0)}.
#'  Default is \code{NULL} (no check).
#' @param ordered [\code{logical(1)}]\cr
#'  Flag whether the arguments provided in \code{args} must be the first
#'  \code{length(args)} arguments of the function in the specified order.
#'  Default is \code{FALSE}.
#' @family basetypes
#' @export
#' @examples
#' testFunction(mean)
#' testFunction(mean, args = "x")
checkFunction = function(x, args = NULL, ordered = FALSE) {
  qassert(ordered, "B1")
  x = try(match.fun(x), silent = TRUE)
  if (inherits(x, "try-error"))
    return("Function not found")

  if (!is.null(args)) {
    qassert(args, "S")
    fargs = names(formals(x))
    if (is.null(fargs))
      fargs = character(0L)

    if (length(args) == 0L) {
      if (length(fargs) > 0L)
        return("May not have any arguments")
      return(TRUE)
    }

    if (ordered) {
      if (any(args != head(fargs, length(args)))) {
        return(sprintf("Must have first formal arguments (ordered): %s", collapse(args)))
      }
    } else {
      tmp = setdiff(args, fargs)
      if (length(tmp))
        return(sprintf("Must have formal arguments: %s", collapse(tmp)))
    }
  }
  return(TRUE)
}

#' @rdname checkFunction
#' @export
assertFunction = function(x, args = NULL, ordered = FALSE, .var.name) {
  res = checkFunction(x, args, ordered)
  makeAssertion(res, vname(x, .var.name))
}

#' @rdname checkFunction
#' @export
testFunction = function(x, args = NULL, ordered = FALSE) {
  isTRUE(checkFunction(x, args, ordered))
}
