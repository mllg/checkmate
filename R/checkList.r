#' Check if an argument is a list
#'
#' @templateVar fn List
#' @template x
#' @inheritParams checkVector
#' @param ... [ANY]\cr
#'  Additional parameters used in a call of \code{\link{checkVector}}.
#' @param types [\code{character}]\cr
#'  Character vector of class names. Each list element must inherit
#'  from at least one of the provided types.
#'  The types \dQuote{logical}, \dQuote{integer}, \dQuote{integerish}, \dQuote{double},
#'  \dQuote{numeric}, \dQuote{complex}, \dQuote{character}, \dQuote{factor}, \dQuote{atomic}, \dQuote{vector}
#'  \dQuote{atomicvector}, \dQuote{array}, \dQuote{matrix}, \dQuote{list}, \dQuote{function},
#'  \dQuote{environment} and \dQuote{null} are supported.
#'  For other types \code{\link[base]{inherits}} is used as a fallback to check \code{x}'s inheritance.
#'  Defaults to \code{character(0)} (no check).
#' @template checker
#' @family basetypes
#' @export
#' @useDynLib checkmate c_check_list
#' @examples
#' testList(list())
#' testList(as.list(iris), types = c("numeric", "factor"))
checkList = function(x, types = character(0L), any.missing = TRUE, all.missing = TRUE, len = NULL, min.len = NULL, max.len = NULL, unique = FALSE, names = NULL) {
  .Call("c_check_list", x, any.missing, all.missing, len, min.len, max.len, unique, names, PACKAGE = "checkmate") %and%
  checkListProps(x, types)
}

#' @rdname checkList
#' @useDynLib checkmate c_check_list
#' @export
assertList = function(x, types = character(0L), any.missing = TRUE, all.missing = TRUE, len = NULL, min.len = NULL, max.len = NULL, unique = FALSE, names = NULL, .var.name) {
  res = .Call("c_check_list", x, any.missing, all.missing, len, min.len, max.len, unique, names, PACKAGE = "checkmate") %and% checkListProps(x, types)
  makeAssertion(res, vname(x, .var.name))
}

#' @rdname checkList
#' @useDynLib checkmate c_check_list
#' @export
testList = function(x, types = character(0L), any.missing = TRUE, all.missing = TRUE, len = NULL, min.len = NULL, max.len = NULL, unique = FALSE, names = NULL) {
  res = .Call("c_check_list", x, any.missing, all.missing, len, min.len, max.len, unique, names, PACKAGE = "checkmate")
  isTRUE(res) && isTRUE(checkListProps(x, types))
}

#' @rdname checkList
#' @template expect
#' @useDynLib checkmate c_check_list
#' @export
expect_list = function(x, types = character(0L), any.missing = TRUE, all.missing = TRUE, len = NULL, min.len = NULL, max.len = NULL, unique = FALSE, names = NULL, info = NULL, label = NULL) {
  res = .Call("c_check_list", x, any.missing, all.missing, len, min.len, max.len, unique, names, PACKAGE = "checkmate") %and% checkListProps(x, types)
  makeExpectation(res, info = info, label = vname(x, label))
}

checkListProps = function(x, types = character(0L)) {
  if (length(types) == 0L)
    return(TRUE)
  qassert(types, "S")

  ind = seq_along(x)
  for (type in types) {
    f = switch(type,
      "logical" = is.logical,
      "integer" = is.integer,
      "integerish" = isIntegerish,
      "double" = is.double,
      "numeric" = is.numeric,
      "complex" = is.complex,
      "character" = is.character,
      "factor" = is.factor,
      "atomic" = is.atomic,
      "vector" = is.vector,
      "atomicvector" = function(x) !is.null(x) && is.atomic(x),
      "array" = is.array,
      "matrix" = is.matrix,
      "function" = is.function,
      "environment" = is.environment,
      "list" = is.list,
      "null" = is.null,
      function(x) inherits(x, type)
    )
    ind = ind[!vapply(x[ind], f, FUN.VALUE = NA, USE.NAMES = FALSE)]
    if (length(ind) == 0L)
      return(TRUE)
  }
  return(sprintf("May only contain the following types: %s", collapse(types)))
}
