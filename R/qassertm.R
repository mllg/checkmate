#' @title Quick checks for multiple variable=rule enumerated as arguments
#'
#' @description
#' Ergonomic wraper for \code{\link{qassert}} to check multiple variable=rule pairs
#'
#' @param ... [\code{var.name}=[\code{character}]]\cr
#'   Any number of named arguments like var.name=rule\cr
#'   See details of \code{\link{qtest}} for rule explanation.
#' @template var.name
#' @return See \code{\link{qassert}}.
#' @seealso \code{\link{qtest}}, \code{\link{qassert}}
#' @useDynLib checkmate
#' @export
#' @examples
#' x=1:10; y=TRUE
#' qassertm(x="i+", y="b")
#'
#' with(data.frame(a=1:26,b=letters), qassertm(a="i+", b="s"))
qassertm <- function(...) {
   in_args <- list(...)
   for (v in names(in_args))
      eval(substitute(qassert(x, spec),
                      list(x=as.name(v), spec=in_args[[v]])),
           envir=parent.frame())
}
