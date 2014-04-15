#' Checks if an argument is a count
#'
#' A count a a single integerish numeric >= 0 which is not missing.
#'
#' @templateVar id Count
#' @template testfuns
#' @param na.ok [\code{logical(1)}]\cr
#'  Are missing values allowed? Default is \code{FALSE}.
#' @export
assertCount = function(x, na.ok = FALSE, .var.name) {
  amsg(testCount(x, na.ok), vname(x, .var.name))
}

#' @rdname assertCount
#' @export
isCount = function(x, na.ok = FALSE) {
  isTRUE(testCount(x))
}

#' @rdname assertCount
#' @export
asCount = function(x, na.ok = FALSE, .var.name) {
  assertCount(x, .var.name = vname(x, .var.name))
  as.integer(x)
}

testCount = function(x, na.ok = FALSE) {
  if (length(x) != 1L)
    return("'%s' must have length 1")
  if (!isIntegerish(x))
    return("'%s' must be integerish")
  if (is.na(x)) {
    if (!na.ok)
      return("'%s' may not be NA")
  } else if (x < 0) {
    return("'%s' must be >= 0")
  }
  return(TRUE)
}
