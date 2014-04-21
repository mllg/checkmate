#' Check if elements of a vector are variable
#'
#' @template checker
#' @inheritParams check_constant
#' @export
#' @useDynLib checkmate c_is_constant
#' @family checker
#' @examples
#' test(c(1, NA), "inconstant")
#'
#' x = c(0, 1 - 0.9 - 0.1)
#' print(identical(x[1], x[2]))
#' print(test(x, "inconstant"))
check_inconstant= function(x, tol = .Machine$double.eps^0.5) {
  if (check_constant_helper(x, tol))
    return("'%s' must have inconstant (varying) elements")
  return(TRUE)
}
