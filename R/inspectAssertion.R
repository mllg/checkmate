#' Inspect an Assertion
#'
#' @description
#' Executes the expression \code{expr} and uses \code{\link[base]{tryCatch}} to catch
#' the first \code{\link[conditions]{assertion_error}} raised.
#'
#' @param expr [\code{expression}]\cr
#'  Code to execute.
#'
#' @return [\code{list}] with named elements \dQuote{message} and \dQuote{x} if an assertion
#'  has been caught, and the return value of \code{expr} otherwise.
#' @export
#' @examples
#' getElement = function(x, i) {
#'   assertAtomicVector(x, any.missing = FALSE)
#'   assertCount(i)
#'   x[i]
#' }
#' inspectAssertion(getElement(1:10, 2))
#' inspectAssertion(getElement(NULL, 1))
#' inspectAssertion(getElement(iris[1:3, ], 1))
#' inspectAssertion(getElement(1:10, -2))
inspectAssertion = function(expr) {
  tryCatch(expr, assertion_error = function(e) {
    res = e[c("message", "attached")]
    names(res) = c("message", "x")
    res
  })
}
