#' Check or assert an argument to be a function
#'
#' @param fun [\code{character} or \code{function}]\cr
#'  Function to check.
#' @param args [\code{character}]\cr
#'  Expected formal arguments.
#' @param ordered [\code{logical(1)}]\cr
#'  Flag whether the arguments provided in \code{args} must be the first
#'  arguments of the function and occur in the given order.
#'  Default is \code{FALSE}.
#' @param .var.name [\code{logical(1)}]\cr
#'  Argument name to print in error message. If missing,
#'  the name of \code{x} will be retrieved via \code{\link[base]{substitute}}.
#' @return [\code{logical(1)}] Returns \code{TRUE} on success.
#'  Throws an exception on failure for assertion.
#' @export
assertFun = function(fun, args, ordered = FALSE, .var.name) {
  amsg(testFun(fun, args, ordered), vname(fun, .var.name))
}

#' @rdname assertFun
#' @export
checkFun = function(fun, args, ordered = FALSE) {
  isTRUE(testFun(fun, args, ordered))
}

#' @rdname asFun
#' @export
asFun = function(fun, args, ordered = FALSE, .var.name) {
  assertFun(fun, args, ordered, .var.name = vname(x, .var.name))
  x
}

testFun = function(fun, args, ordered = FALSE) {
  fun = try(match.fun(fun), silent=TRUE)
  if (inherits(fun, "try-error"))
    return("Function '%s' not found")

  if (!missing(args)) {
    qassert(args, "S")
    qassert(ordered, "B1")
    fargs = names(formals(fun))
    if (is.null(fargs))
      fargs = character(0L)

    if (ordered) {
      if (any(args != head(fargs, length(args)))) {
        return(paste0("Function '%s' must have first formal arguments (ordered): ", paste(args, collapse=",")))
      }
    } else {
      tmp = setdiff(args, fargs)
      if (length(tmp))
        return(paste0("Function '%s' is missing formal arguments: ", paste(tmp, collapse=",")))
    }
  }
  return(TRUE)
}
