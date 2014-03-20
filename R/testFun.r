testFun = function(fun, args, ordered = FALSE) {
  fun = match.fun(fun)

  if (!missing(args)) {
    qassert(args, "S")
    qassert(ordered, "B1")
    fargs = names(formals(fun))
    if (is.null(fargs))
      fargs = character(0L)

    if (ordered) {
      if (any(args != head(fargs, length(args)))) {
        return(paste0("Function must have first formal arguments (ordered): ", paste(args, collapse=",")))
      }
    } else {
      tmp = setdiff(args, fargs)
      if (length(tmp))
        return(paste0("Function is missing formal arguments: ", paste(tmp, collapse=",")))
    }
  }
  return(TRUE)
}


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
#' @return [\code{logical(1)}] Returns \code{TRUE} on success and
#'  throws an exception on failure for assertion.
#' @export
checkFun = function(fun, args, ordered = FALSE) {
  isTRUE(testFun(fun, args, ordered))
}

#' @rdname checkFun
#' @export
asssertFun = function(fun, args, ordered = FALSE) {
  amsg(testFun(fun, args, ordered))
}
