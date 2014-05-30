#' Check if an argument is a list
#'
#' @templateVar fn List
#' @template checker
#' @inheritParams checkVector
#' @param ... [ANY]\cr
#'  Additional parameters used in a call of \code{\link{checkVector}}.
#' @param types [\code{character}]\cr
#'  Character vector of class names. Each list element must inherit
#'  from at least one of the provided types.
#'  Defaults to \code{character(0)} (no check).
#' @family basetypes
#' @export
#' @useDynLib checkmate c_check_list
#' @examples
#'  testList(list())
#'  testList(as.list(iris), types = c("numeric", "factor"))
checkList = function(x, types = character(0L), any.missing = TRUE, all.missing = TRUE, len = NULL, min.len = NULL, max.len = NULL, unique = FALSE, names = NULL) {
  .Call("c_check_list", x, any.missing, all.missing, len, min.len, max.len, unique, names, PACKAGE = "checkmate") %and%
  checkListProps(x, types)
}

checkListProps = function(x, types = character(0L)) {
  if (length(types) == 0L)
    return(TRUE)
  qassert(types, "S")
  ok = vapply(x, inherits, what = types, FUN.VALUE = NA, USE.NAMES = FALSE)
  if (all(ok))
    return(TRUE)
  return(sprintf("May only contain the following types: %s", collapse(types)))
}

#' @rdname checkList
#' @useDynLib checkmate c_check_list
#' @export
assertList = function(x, types = character(0L), any.missing = TRUE, all.missing = TRUE, len = NULL, min.len = NULL, max.len = NULL, unique = FALSE, names = NULL, .var.name) {
  makeAssertion(
    .Call("c_check_list", x, any.missing, all.missing, len, min.len, max.len, unique, names, PACKAGE = "checkmate") %and%
    checkListProps(x, types)
  , vname(x, .var.name))
}

#' @rdname checkList
#' @useDynLib checkmate c_check_list
#' @export
testList = function(x, types = character(0L), any.missing = TRUE, all.missing = TRUE, len = NULL, min.len = NULL, max.len = NULL, unique = FALSE, names = NULL) {
  isTRUE(
    .Call("c_check_list", x, any.missing, all.missing, len, min.len, max.len, unique, names, PACKAGE = "checkmate") %and%
    checkListProps(x, types)
  )
}
