mkqassert <- function(varname, rule, frame)
      eval(substitute(qassert(x, spec), list(x=as.name(varname), spec=rule)),
                      envir=frame)

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
#' @export
#' @examples
#' x=1:10; y=TRUE
#' qassertm(x="i+", y="b")
#'
#' with(data.frame(a=1:26,b=letters), qassertm(a="i+", b="s"))
qassertm <- function(...) {
   in_args <- list(...)
   for (v in names(in_args)) mkqassert(v, in_args[[v]], parent.frame())
}

#' @title Check single rule against all or enumerated variables
#'
#' @description
#' Ergonomic wraper for \code{\link{qassert}} to check multiple variables against a single rule
#'
#' @param rule [[\code{character}]]\cr
#'   Any number of named arguments like var.name=rule\cr
#'   See details of \code{\link{qtest}} for rule explanation.
#' @param ... [[\code{var.name}]]\cr
#' list of unquoted variables that should match \code{rule}
#' if none provided, uses all variables in local scope
#' @return See \code{\link{qassert}}.
#' @seealso \code{\link{qassertm}}
#' @export
#' @examples
#' x <- TRUE; y <- FALSE
#' # check all variables, scoped inside function
#' foofunc <- function(x, y) { qassert_all('n'); print(x); }
#' foofunc(1, 2)
#' # only enumerated variables
#' qassert_all('l', x, y)
#'
qassert_all <- function(rule, ...) {
   qassert(rule,'s')
   varlist <- lapply(match.call(expand.dots = FALSE)$..., as.character)
   if(length(varlist)==0L) varlist <- ls(envir=parent.frame())
   for (v in varlist) mkqassert(v, rule, parent.frame())
}
