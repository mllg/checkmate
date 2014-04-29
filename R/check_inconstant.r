#' Check if elements of a vector are inequal / inconstant
#'
#' Note that zero-length input is treated as constant.
#'
#' @template checker
#' @inheritParams check_constant
#' @export
#' @family constant
#' @examples
#'  test(c(1, NA), "inconstant")
#'  test(c(0, 1-0.9-0.1), "inconstant")
#'  test(c(0, 1-0.9-0.1), "inconstant", tol = 0)
check_inconstant = function(x, tol = .Machine$double.eps^0.5) {
  if (length(x) == 0L)
    return(FALSE)
  if (check_constant_helper(x, tol))
    return("'%s' must have inconstant (varying) elements")
  return(TRUE)
}
