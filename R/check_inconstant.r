#' Check if elements of a vector are inequal / inconstant
#'
#' Note that zero-length input is treated as constant.
#'
#' @template checker
#' @inheritParams checkConstant
#' @export
#' @family constant
#' @examples
#'  test(c(1, NA), "inconstant")
#'  test(c(0, 1-0.9-0.1), "inconstant")
#'  test(c(0, 1-0.9-0.1), "inconstant", tol = 0)
checkInconstant = function(x, tol = .Machine$double.eps^0.5) {
  if (length(x) == 0L)
    return(FALSE)
  if (checkConstantHelper(x, tol))
    return("'%s' must have inconstant (varying) elements")
  return(TRUE)
}

#' @rdname checkInconstant
#' @export
assertInconstant = function(x, tol = .Machine$double.eps^0.5, .var.name) {
  makeAssertion(checkInconstant(x, tol), vname(x, .var.name))
}

#' @rdname checkInconstant
#' @export
testInconstant = function(x, tol = .Machine$double.eps^0.5) {
  makeTest(checkInconstant(x, tol))
}
