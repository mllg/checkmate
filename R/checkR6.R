#' Check if an argument is a R6 class
#'
#' @templateVar fn Class
#' @template x
#' @inheritParams checkClass
#' @param cloneable [\code{logical(1)}]\cr
#'  If \code{TRUE}, check that \code{x} has a \code{clone} method. If \code{FALSE}, ensure that
#'  \code{x} is not cloneable.
#' @param public [\code{character}]\cr
#'  Names of expected public slots. This includes active bindings.
#' @param private [\code{character}]\cr
#'  Names of expected private slots.
#' @template null.ok
#' @template checker
#' @export
#' @examples
#' library(R6)
#' generator = R6Class("Bar",
#'   public = list(a = 5),
#'   private = list(b = 42),
#'   active = list(c = function() 99)
#' )
#' x = generator$new()
#' checkR6(x, "Bar", cloneable = TRUE, public = "a")
checkR6 = function(x, classes = NULL, ordered = FALSE, cloneable = NULL, public = NULL, private = NULL, null.ok = FALSE) {
  if (!requireNamespace("R6", quietly = TRUE))
    stop("Install package 'R6' to perform checks of R6 classes")
  if (is.null(x)) {
    if (null.ok)
      return(TRUE)
    return("Must be an R6 class, not 'NULL'")
  }
  if (!R6::is.R6(x))
    return(paste0("Must be an R6 class", if (null.ok) " (or 'NULL')" else "", sprintf(", not %s", guessType(x))))
  checkClass(x, c(classes, "R6"), ordered) %and% checkR6Props(x, cloneable, public, private)
}

checkR6Props = function(x, cloneable = NULL, public = NULL, private = NULL) {
  if (!is.null(cloneable)) {
    qassert(cloneable, "B1")
    if (cloneable) {
      if (!exists("clone", envir = x))
        return("Must be cloneable")
    } else {
      if (exists("clone", envir = x))
        return("May not be cloneable")
    }
  }

  if (!is.null(public)) {
    qassert(public, "S")
    i = wf(public %nin% ls(x, all.names = TRUE))
    if (length(i) > 0L)
      return(sprintf("Must provide the public slot '%s'", public[i]))
  }

  if (!is.null(private)) {
    qassert(private, "S")
    i = wf(private %nin% ls(x$.__enclos_env__[["private"]], all.names = TRUE))
    if (length(i) > 0L)
      return(sprintf("Must provide the private slot '%s'", private[i]))
  }

  return(TRUE)
}

#' @export
#' @rdname checkR6
check_r6 = checkR6

#' @export
#' @include makeAssertion.R
#' @template assert
#' @rdname checkR6
assertR6 = makeAssertionFunction(checkR6)

#' @export
#' @rdname checkR6
assert_r6 = assertR6

#' @export
#' @include makeTest.R
#' @rdname checkR6
testR6 = makeTestFunction(checkR6)

#' @export
#' @rdname checkR6
test_r6 = testR6

#' @export
#' @include makeExpectation.R
#' @template expect
#' @rdname checkR6
expect_r6 = makeExpectationFunction(checkR6)
