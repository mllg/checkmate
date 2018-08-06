#' Check if an argument is a function
#'
#' @templateVar fn Function
#' @template x
#' @param args [\code{character}]\cr
#'  Expected formal arguments. Checks that a function has no arguments if
#'  set to \code{character(0)}.
#'  Default is \code{NULL} (no check).
#' @param ordered [\code{logical(1)}]\cr
#'  Flag whether the arguments provided in \code{args} must be the first
#'  \code{length(args)} arguments of the function in the specified order.
#'  Default is \code{FALSE}.
#' @param nargs [\code{integer(1)}]\cr
#'  Required number of arguments, without \code{...}.
#'  Default is \code{NULL} (no check).
#' @template null.ok
#' @template checker
#' @family basetypes
#' @export
#' @examples
#' testFunction(mean)
#' testFunction(mean, args = "x")
checkFunction = function(x, args = NULL, ordered = FALSE, nargs = NULL, null.ok = FALSE) {
  qassert(null.ok, "B1")
  if (is.null(x)) {
    if (null.ok)
      return(TRUE)
    return("Must be a function, not 'NULL'")
  }

  if (!is.function(x))
    return(sprintf("Must be a function%s, not '%s'", if (null.ok) " (or 'NULL')" else "", guessType(x)))

  if (!is.null(args)) {
    qassert(args, "S")
    fargs = names(formals(args(x))) %??% character(0L)

    if (length(args) == 0L) {
      if (length(fargs) > 0L)
        return("May not have any arguments")
      return(TRUE)
    }

    qassert(ordered, "B1")
    if (ordered) {
      if (any(args != head(fargs, length(args)))) {
        return(sprintf("Must have first formal arguments (ordered): %s", paste0(args, collapse = ",")))
      }
    } else {
      tmp = setdiff(args, fargs)
      if (length(tmp))
        return(sprintf("Must have formal arguments: %s", paste0(tmp, collapse = ",")))
    }
  }

  if (!is.null(nargs)) {
    nargs = asCount(nargs)
    fnargs = length(setdiff(names(formals(args(x))) %??% character(0L), "..."))
    if (nargs != fnargs)
      return(sprintf("Must have exactly %i formal arguments, but has %i", nargs, fnargs))
  }

  return(TRUE)
}

#' @export
#' @rdname checkFunction
check_function = checkFunction

#' @export
#' @include makeAssertion.R
#' @template assert
#' @rdname checkFunction
assertFunction = makeAssertionFunction(checkFunction, use.namespace = FALSE)

#' @export
#' @rdname checkFunction
assert_function = assertFunction

#' @export
#' @include makeTest.R
#' @rdname checkFunction
testFunction = makeTestFunction(checkFunction)

#' @export
#' @rdname checkFunction
test_function = testFunction

#' @export
#' @include makeExpectation.R
#' @template expect
#' @rdname checkFunction
expect_function = makeExpectationFunction(checkFunction, use.namespace = FALSE)
