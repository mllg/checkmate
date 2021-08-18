test_backend = new.env(parent = emptyenv())

#' @title Select Backend for Unit Tests
#'
#' @description
#' Allows to explicitly select a backend for the unit tests.
#' Currently supported are \code{"testthat"} and \code{"tinytest"}.
#' The respective package must be installed and are loaded (but not attached).
#'
#' If this function is not explicitly called, defaults to \code{"testthat"} unless
#' the \code{"tinytest"}'s namespace is loaded.
#'
#' @param name [\code{character(1)}]\cr
#'  \code{"testthat"} or \code{"tinytest"}.
#' @return \code{NULL} (invisibly).
#' @export
register_test_backend = function(name) {
  name = match.arg(name, c("testthat", "tinytest"))
  if (name == "testthat") {
    requireNamespace("testthat")
    test_backend$name = "testthat"
  } else {
    requireNamespace("tinytest")
    test_backend$name = "tinytest"
  }
  invisible(NULL)
}

detect_test_backend = function() {
  if ("tinytest" %in% .packages())
    return("tinytest")
  return("testthat")
}

get_test_backend = function() {
  if (is.null(test_backend$name)) {
    test_backend$name = detect_test_backend()
    register_test_backend(test_backend$name)
  }
  test_backend$name
}

#' @title Turn a Check into an Expectation
#'
#' @description
#' \code{makeExpectation} is the internal function used to evaluate the result of a
#' check and turn it into an \code{\link[testthat]{expectation}}.
#' \code{makeExceptionFunction} can be used to automatically create an expectation
#' function based on a check function (see example).
#'
#' @template x
#' @param res [\code{TRUE} | \code{character(1)}]\cr
#'  The result of a check function: \code{TRUE} for successful checks,
#'  and an error message as string otherwise.
#' @param info [\code{character(1)}]\cr
#'   See \code{\link[testthat]{expect_that}}
#' @param label [\code{character(1)}]\cr
#'   See \code{\link[testthat]{expect_that}}
#' @return \code{makeExpectation} invisibly returns the checked object.
#'   \code{makeExpectationFunction} returns a \code{function}.
#' @export
#' @family CustomConstructors
#' @include helper.R
#' @examples
#' # Simple custom check function
#' checkFalse = function(x) if (!identical(x, FALSE)) "Must be FALSE" else TRUE
#'
#' # Create the respective expect function
#' expect_false = function(x, info = NULL, label = vname(x)) {
#'   res = checkFalse(x)
#'   makeExpectation(x, res, info = info, label = label)
#' }
#'
#' # Alternative: Automatically create such a function
#' expect_false = makeExpectationFunction(checkFalse)
#' print(expect_false)
makeExpectation = function(x, res, info, label) {
  backend = get_test_backend()
  if (backend == "testthat") {
    if (!requireNamespace("testthat", quietly = TRUE))
      stop("Package 'testthat' is required for checkmate's 'expect_*' extensions with backend 'testthat'")

    if (!is.null(info)) {
      info = sprintf("Additional info: %s", info)
    }

    if (isTRUE(res)) {
      testthat::succeed(info = info)
    } else {
      testthat::fail(sprintf("Check on '%s' failed: %s", label, res), info = info)
    }
    invisible(x)
  } else {
    if (!requireNamespace("tinytest", quietly = TRUE))
      stop("Package 'tinytest' is required for checkmate's 'expect_*' extensions with backend 'tinytest'")
    call = sys.call(sys.parent(1L))
    if (isTRUE(res)) {
      tinytest::tinytest(TRUE, call = call)
    } else {
      tinytest::tinytest(FALSE,
        call = call,
        diff = if (is.character(res)) res else "",
        info = if (is.null(info)) NA_character_ else info,
        short = "data"
      )
    }
  }
}

#' @rdname makeExpectation
#' @template makeFunction
#' @template use.namespace
#' @export
makeExpectationFunction = function(check.fun, c.fun = NULL, use.namespace = FALSE, env = parent.frame()) {
  fun.name = if (!is.character(check.fun)) deparse(substitute(check.fun)) else check.fun
  check.fun = match.fun(check.fun)
  check.args = fun.args = formals(args(check.fun))
  x.name = names(fun.args[1L])
  x = NULL

  new.fun = function() TRUE
  body = sprintf("if (missing(%s)) stop(sprintf(\"Argument '%%s' is missing\", label))", x.name)

  if (is.null(c.fun)) {
    body = paste0(body, sprintf("; res = %s(%s)", fun.name, paste0(names(check.args), collapse = ", ")))
  } else {
    body = paste0(body, sprintf("; res = .Call(%s)", paste0(c(c.fun, names(check.args)), collapse = ", ")))
  }

  if (use.namespace) {
    formals(new.fun) = c(fun.args, alist(info = NULL, label = checkmate::vname(x)))
    body = paste0(body, "; checkmate::makeExpectation")
  } else {
    formals(new.fun) = c(fun.args, alist(info = NULL, label = vname(x)))
    body = paste0(body, "; makeExpectation")
  }
  body = paste0(body, sprintf("(%s, res, info, label)", x.name))

  body(new.fun) = parse(text = paste("{", body, "}"))
  environment(new.fun) = env
  return(new.fun)
}
