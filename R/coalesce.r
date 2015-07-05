#' Coalesce operator
#' @rdname coalesce
#'
#' @description
#' Returns the left hand side if not missing nor \code{NULL}, and
#' the right hand side otherwise.
#'
#' @param lhs [any]\cr
#' Left hand side of the operator. Is returned, if not missing or \code{NULL}.
#' @param rhs [any]\cr
#' Right hand side of the operator. Is returned, if \code{lhs} is missing or \code{NULL}.
#' @return Either \code{lhs} or \code{rhs}.
#' @export
#' @examples
#' print(NULL %??% 1 %??% 2)
#' print(names(iris) %??% letters[seq_len(ncol(iris))])
"%??%" = function(lhs, rhs) {
  if (missing(lhs) || is.null(lhs)) rhs else lhs
}
