#' @title Sets of Names
#'
#' @description
#' Little helper function to be used if you want to check that the names of an object are setequal,
#' equal or a subset of certain names.
#'
#' @param x [\code{character}]\cr
#'   Character vector of names.
#' @return [\code{character}]. Returns \code{x} with an attribute attached.
#' @rdname named
#' @export
#' @examples
#' x = setNames(1:3, letters[1:3])
#' checkNumeric(x, names = .in(letters))
#' checkNumeric(x, names = .setequal(letters[1:3]))
#' checkDataFrame(iris, col.names = .setequal(sample(names(iris))))
.setequal = function(x) {
  qassert(x, "S", .var.name = "set of names for .setequal()")
  x = unique(x)
  attr(x, "named.cmp") = "setequal"
  x
}

#' @rdname named
#' @export
.in = function(x) {
  qassert(x, "S", .var.name = "set of names for .in()")
  x = unique(x)
  attr(x, "named.cmp") = "in"
  x
}

#' @rdname named
#' @export
.equal = function(x) {
  qassert(x, "S", .var.name = "vector of names for .equal()")
  attr(x, "named.cmp") = "equal"
  x
}
