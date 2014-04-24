#' Check if all elements of a vector are equal
#'
#' @template checker
#' @param tol [\code{double(1)}]\cr
#'  Numerical tolerance used if \code{x} is of type \code{double} or \code{complex}.
#'  Default is \code{sqrt(.Machine$double.eps)}.
#' @family checker
#' @export
#' @examples
#'  test(c(0, 1-0.9-0.1), "constant")
#'  test(c(0, 1-0.9-0.1), "constant", tol = 0)
check_constant = function(x, tol = .Machine$double.eps^0.5) {
  if (!check_constant_helper(x, tol))
    return("'%s' must have constant elements")
  return(TRUE)
}

check_constant_helper = function(x, tol = .Machine$double.eps^0.5) {
  if (length(x) <= 1L)
    return(TRUE)

  n.na = sum(is.na(x))
  if (n.na > 0L)
    return(n.na == length(x))

  if (is.atomic(x)) {
    if (is.numeric(x)) {
      return(all(abs(x - x[1L]) < tol))
    } else if(is.complex(x)) {
      d = abs(x - x[1L])
      return(all(Re(d) < tol & Im(d) < tol))
    }
    # logical, character, integer, ...
    return(all(x == x[[1L]]))
  }
  all(vapply(tail(x, -1L), identical, y=x[[1L]], FUN.VALUE=NA))
}
