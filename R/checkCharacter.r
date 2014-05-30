#' Check if an argument is a vector of type character
#'
#' @templateVar fn Character
#' @template na-handling
#' @template checker
#' @inheritParams checkVector
#' @param pattern [\code{character(1L)}]\cr
#'  Regular expression as used in \code{\link[base]{grepl}}.
#'  All elements of \code{x} must comply to this pattern.
#'  Defaults to \code{NULL}.
#' @param fixed [\code{logical(1)}]\cr
#'  Fixed string as used in \code{\link[base]{grepl}} with \code{fixed = TRUE}.
#'  All elements of \code{x} must contain this string.
#'  Default is \code{NULL}.
#' @param ignore.case [\code{logical(1)}]\cr
#'  See \code{\link[base]{grepl}}. Default is \code{FALSE}.
#' @param fixed [\code{logical(1)}]\cr
#'  See \code{\link[base]{grepl}}. Default is \code{FALSE}.
#' @param min.chars [\code{integer(1)}]\cr
#'  Minimum number of characters in each element of \code{x}.
#' @family basetypes
#' @useDynLib checkmate c_check_character
#' @export
#' @examples
#'  testCharacter(letters, min.len = 1, any.missing = FALSE)
#'  testCharacter(letters, min.chars = 2)
#'  testCharacter("example", pattern = "xa")
checkCharacter = function(x, min.chars = 0L, pattern = NULL, fixed = FALSE, ignore.case = FALSE, any.missing = TRUE, all.missing = TRUE, len = NULL, min.len = NULL, max.len = NULL,  unique = FALSE, named = NULL) {
  .Call("c_check_character", x, min.chars, any.missing, all.missing, len, min.len, max.len, unique, named, PACKAGE = "checkmate") %and%
  checkCharacterProps(x, pattern, fixed, ignore.case)
}

checkCharacterProps = function(x, pattern = NULL, fixed = FALSE, ignore.case = FALSE) {
  if (!is.null(pattern)) {
    qassert(pattern, "S1")
    qassert(fixed, "B1")
    qassert(ignore.case, "B1")
    ok = grepl(pattern, x, fixed = fixed, ignore.case = ignore.case)
    if(!all(ok))
      return(sprintf("Must comply to pattern '%s", pattern))
  }
  return(TRUE)
}

#' @rdname checkCharacter
#' @useDynLib checkmate c_check_character
#' @export
assertCharacter = function(x, min.chars = 0L, pattern = NULL, fixed = FALSE, ignore.case = FALSE, any.missing = TRUE, all.missing = TRUE, len = NULL, min.len = NULL, max.len = NULL,  unique = FALSE, named = NULL, .var.name) {
  makeAssertion(
    .Call("c_check_character", x, min.chars, any.missing, all.missing, len, min.len, max.len, unique, named, PACKAGE = "checkmate") %and%
    checkCharacterProps(x, pattern, fixed, ignore.case)
  , vname(x, .var.name))
}

#' @rdname checkCharacter
#' @useDynLib checkmate c_check_character
#' @export
testCharacter = function(x, min.chars = 0L, pattern = NULL, fixed = FALSE, ignore.case = FALSE, any.missing = TRUE, all.missing = TRUE, len = NULL, min.len = NULL, max.len = NULL,  unique = FALSE, named = NULL) {
  isTRUE(
    .Call("c_check_character", x, min.chars, any.missing, all.missing, len, min.len, max.len, unique, named, PACKAGE = "checkmate") %and%
    checkCharacterProps(x, pattern, fixed, ignore.case)
  )
}
