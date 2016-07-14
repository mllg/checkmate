#' @title Sets of Names
#'
#' @description
#' Little helper function to be used if you want to check that the names of an object are setequal,
#' equal or a subset of certain names.
#'
#'
#' @param x [\code{character}]\cr
#'   Character vector of names.
#' @return [\code{character}]. Returns \code{x} with an attribute attached.
#' @export
#' @examples
#' checkNumeric(1, names = .setequal(letters))
#' checkDataFrame(iris, col.names = .in("Species"))
.setequal = function(x) {
  x = unique(x)
  attr(x, "named.cmp") = "setequal"
  x
}

#' @rdname .setequal
#' @export
.in = function(x) {
  x = unique(x)
  attr(x, "named.cmp") = "in"
  x
}

#' @rdname .setequal
#' @export
.equal = function(x) {
  attr(x, "named.cmp") = "equal"
  x
}
