#' Check if an argument is a vector of type character
#'
#' @templateVar fn Character
#' @template x
#' @template na-handling
#' @inheritParams checkVector
#' @param pattern [\code{character(1L)}]\cr
#'  Regular expression as used in \code{\link[base]{grepl}}.
#'  All non-missing elements of \code{x} must comply to this pattern.
#' @param fixed [\code{character(1)}]\cr
#'  Substring to detect in \code{x}. Will be used as \code{pattern} in \code{\link[base]{grepl}}
#'  with option \code{fixed} set to \code{TRUE}.
#'  All non-missing elements of \code{x} must contain this substring.
#' @param ignore.case [\code{logical(1)}]\cr
#'  See \code{\link[base]{grepl}}. Default is \code{FALSE}.
#' @param min.chars [\code{integer(1)}]\cr
#'  Minimum number of characters for each element of \code{x}.
#' @template null.ok
#' @template checker
#' @family basetypes
#' @useDynLib checkmate c_check_character
#' @export
#' @examples
#' testCharacter(letters, min.len = 1, any.missing = FALSE)
#' testCharacter(letters, min.chars = 2)
#' testCharacter("example", pattern = "xa")
checkCharacter = function(x, min.chars = NULL, pattern = NULL, fixed = NULL, ignore.case = FALSE, any.missing = TRUE, all.missing = TRUE, len = NULL, min.len = NULL, max.len = NULL, unique = FALSE, names = NULL, null.ok = FALSE) {
  .Call(c_check_character, x, min.chars, any.missing, all.missing, len, min.len, max.len, unique, names, null.ok) %and%
  checkCharacterPattern(x, pattern, fixed, ignore.case)
}

checkCharacterPattern = function(x, pattern = NULL, fixed = NULL, ignore.case = FALSE) {
  if (!is.null(x)) {
    if (!is.null(pattern)) {
      qassert(pattern, "S1")
      ok = grepl(pattern, x[!is.na(x)], fixed = FALSE, ignore.case = ignore.case)
      if (!all(ok))
        return(sprintf("Must comply to pattern '%s'", pattern))
    }
    if (!is.null(fixed)) {
      qassert(fixed, "S1")
      ok = grepl(fixed, x[!is.na(x)], fixed = TRUE, ignore.case = ignore.case)
      if (!all(ok))
        return(sprintf("Must contain substring '%s'", fixed))
    }
  }
  return(TRUE)
}

#' @export
#' @rdname checkCharacter
check_character = checkCharacter

#' @export
#' @include makeAssertion.R
#' @template assert
#' @rdname checkCharacter
assertCharacter = makeAssertionFunction(checkCharacter)

#' @export
#' @rdname checkCharacter
assert_character = assertCharacter

#' @export
#' @include makeTest.R
#' @rdname checkCharacter
testCharacter = makeTestFunction(checkCharacter)

#' @export
#' @rdname checkCharacter
test_character = testCharacter

#' @export
#' @include makeExpectation.R
#' @template expect
#' @rdname checkCharacter
expect_character = makeExpectationFunction(checkCharacter)
