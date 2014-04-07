#' Checks if an argument is a count
#'
#' A count a a single integerish numeric >= 0 which is not missing.
#'
#' @templateVar id Count
#' @template testfuns
#' @export
assertCount = function(x, .var.name) {
  amsg(testCount(x), vname(x, .var.name))
}

#' @rdname assertCount
#' @export
isCount = function(x) {
  isTRUE(testCount(x))
}

#' @rdname assertCount
#' @export
asCount = function(x, .var.name) {
  assertCount(x, .var.name = vname(x, .var.name))
  x
}

testCount = function(x) {
  if (length(x) != 1L || !isIntegerish(x) || is.na(x) || x < 0)
    return("'%s' must be a count")
  return(TRUE)
}
