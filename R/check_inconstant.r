#' Check if elements of a vector are variable
#'
#' @template checker
#' @inheritParams check_constant
#' @export
#' @family checker
#' @examples
#'  test(c(1, NA), "inconstant")
#'  test(c(0, 1-0.9-0.1), "inconstant")
#'  test(c(0, 1-0.9-0.1), "inconstant", tol = 0)
check_inconstant = function(x, tol = .Machine$double.eps^0.5) {
  if (check_constant_helper(x, tol))
    return("'%s' must have inconstant (varying) elements")
  return(TRUE)
}
