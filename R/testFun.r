#' Check or assert an argument to be a function
#'
#' @templateVar id Fun
#' @template testfuns
#' @param args [\code{character}]\cr
#'  Expected formal arguments.
#' @param ordered [\code{logical(1)}]\cr
#'  Flag whether the arguments provided in \code{args} must be the first
#'  arguments of the function and occur in the given order.
#'  Default is \code{FALSE}.
#' @export
assertFun = function(x, args, ordered = FALSE, .var.name) {
  amsg(testFun(x, args, ordered), vname(x, .var.name))
}

#' @rdname assertFun
#' @export
isFun = function(x, args, ordered = FALSE) {
  isTRUE(testFun(x, args, ordered))
}

#' @rdname assertFun
#' @export
asFun = function(x, args, ordered = FALSE, .var.name) {
  assertFun(x, args, ordered, .var.name = vname(x, .var.name))
  match.fun(x, silent=TRUE)
}

testFun = function(x, args, ordered = FALSE) {
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
