#' Check if an argument is NULL
#'
#' @templateVar fn Null
#' @template x
#' @template checker
#' @export
#' @examples
#' testNull(NULL)
#' testNull(1)
checkNull = function(x) {
  if (!is.null(x))
    return("Must be NULL")
  return(TRUE)
}

#' @rdname checkNull
#' @export
assertNull = function(x, .var.name) {
  res = checkNull(x)
  makeAssertion(res, vname(x, .var.name))
}

#' @rdname checkNull
#' @export
testNull = function(x) {
  is.null(x)
}
