#' Coalesce operator
#' @rdname coalesce
#'
#' @description
#' Returns the left hand side if not missing nor \code{NULL}, and
#' the right hand side otherwise.
#' @export
#' @examples
#' print(NULL %??% 1 %??% 2)
#' print(names(iris) %??% letters[seq_len(ncol(iris))])
"%??%" = function(lhs, rhs) {
  if (missing(lhs) || is.null(lhs)) rhs else lhs
}
