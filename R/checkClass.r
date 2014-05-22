#' Check argument inheritance
#'
#' @templateVar fn Class
#' @template checker
#' @param classes [\code{character}]\cr
#'  Class names to check for inheritance.
#' @param ordered [\code{logical(1)}]\cr
#'  Expect \code{x} to be specialized in provided order.
#'  Default is \code{FALSE}.
#' @export
#' @examples
#'  # Create an object with classes "foo" and "bar"
#'  x = 1
#'  class(x) = c("foo", "bar")
#'
#'  # is x of class "foo"?
#'  test(x, "class", "foo")
#'
#'  # is x of class "foo" and "bar"?
#'  test(x, "class", c("foo", "bar"))
#'
#'  # is x most specialized as "bar"?
#'  test(x, "class", "bar", ordered = TRUE)
checkClass = function(x, classes, ordered = FALSE) {
  qassert(classes, "S")
  qassert(ordered, "B1")
  ord = inherits(x, classes, TRUE)
  w = which.first(ord == 0L)
  if (length(w) > 0L)
    return(sprintf("Must have class '%s'", classes[w]))
  if (ordered) {
    w = which.first(ord != seq_along(ord))
    if (length(w) > 0L)
      return(sprintf("Must have class '%s' in position %i", classes[w], w))
  }
  return(TRUE)
}

#' @rdname checkClass
#' @export
assertClass = function(x, classes, ordered = FALSE, .var.name) {
  makeAssertion(checkClass(x, classes, ordered), vname(x, .var.name))
}

#' @rdname checkClass
#' @export
testClass = function(x, classes, ordered = FALSE) {
  makeTest(checkClass(x, classes, ordered))
}
