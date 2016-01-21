#' Check if an argument is a vector of type character
#'
#' @templateVar fn Character
#' @template x
#' @template na-handling
#' @inheritParams checkVector
#' @param pattern [\code{character(1L)}]\cr
#'  Regular expression as used in \code{\link[base]{grepl}}.
#'  All elements of \code{x} must comply to this pattern.
#'  Defaults to \code{NULL}.
#' @param ignore.case [\code{logical(1)}]\cr
#'  See \code{\link[base]{grepl}}. Default is \code{FALSE}.
#' @param fixed [\code{logical(1)}]\cr
#'  See \code{\link[base]{grepl}}. Default is \code{FALSE}.
#' @param min.chars [\code{integer(1)}]\cr
#'  Minimum number of characters in each element of \code{x}.
#' @template checker
#' @family basetypes
#' @useDynLib checkmate c_check_character
#' @export
#' @examples
#' testCharacter(letters, min.len = 1, any.missing = FALSE)
#' testCharacter(letters, min.chars = 2)
#' testCharacter("example", pattern = "xa")
checkCharacter = function(x, min.chars = NULL, pattern = NULL, fixed = FALSE, ignore.case = FALSE, any.missing = TRUE, all.missing = TRUE, len = NULL, min.len = NULL, max.len = NULL,  unique = FALSE, names = NULL) {
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
  .Call(c_check_character, x, min.chars, any.missing, all.missing, len, min.len, max.len, unique, names) %and%
  checkCharacterProps(x, pattern, fixed, ignore.case)
}

#' @export
#' @include makeAssertion.r
#' @template assert
#' @rdname checkCharacter
assertCharacter = makeAssertionFunction(checkCharacter)

#' @export
#' @rdname checkCharacter
assert_character = assertCharacter

#' @export
#' @include makeTest.r
#' @rdname checkCharacter
testCharacter = makeTestFunction(checkCharacter)

#' @export
#' @rdname checkCharacter
test_character = testCharacter

#' @export
#' @include makeExpectation.r
#' @template expect
#' @rdname checkCharacter
expect_character = makeExpectationFunction(checkCharacter)
