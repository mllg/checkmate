#' Combine multiple checks into one assertion
#'
#' @description
#' You can call this function with an arbitrary number of of \code{check*}
#' functions, i.e. functions provided by this package or your own functions which
#' return \code{TRUE} on success and the error message as \code{character(1)} otherwise.
#' The resulting assertion is successful, if \code{combine} is
#' \dQuote{or} (default) and at least one check evaluates to \code{TRUE} or
#' \code{combine} is \dQuote{and} and all checks evaluate to \code{TRUE}.
#' Otherwise, \code{assert} throws an informative error message.
#'
#' @param ... [any]\cr
#'  List of calls to check functions.
#' @param combine [\code{character(1)}]\cr
#'  \dQuote{or} or \dQuote{and} to combine the check functions with an OR
#'  or AND, respectively.
#' @template assert
#' @return Throws an error (or pushes the error message to an
#'   \code{\link{AssertCollection}} if \code{add} is not \code{NULL})
#'   if the checks fail and invisibly returns \code{TRUE} otherwise.
#' @export
#' @examples
#' x = 1:10
#' assert(checkNull(x), checkInteger(x, any.missing = FALSE))
#' collection <- makeAssertCollection()
#' assert(checkChoice(x, c("a", "b")), checkDataFrame(x), add = collection)
#' collection$getMessages()
assert = function(..., combine = "or", .var.name = NULL, add = NULL) {
  assertChoice(combine, c("or", "and"))
  assertClass(add, "AssertCollection", .var.name = "add", null.ok = TRUE)
  dots = match.call(expand.dots = FALSE)$...
  assertCharacter(.var.name, null.ok = TRUE, min.len = 1L, max.len = length(dots))
  env = parent.frame()
  if (combine == "or") {
    msgs = character(length(dots))
    for (i in seq_along(dots)) {
      val = eval(dots[[i]], envir = env)
      if (isTRUE(val))
        return(invisible(TRUE))
      msgs[i] = as.character(val)
    }
    if (is.null(.var.name))
      .var.name = vapply(dots, function(x) as.character(x)[2L], FUN.VALUE = NA_character_)
    if (length(msgs) > 1L) {
      msgs = sprintf("%s(%s): %s", vapply(dots, function(x) as.character(x)[1L], FUN.VALUE = NA_character_), .var.name, msgs)
      msgs = paste0(c("One of the following must apply:", strwrap(msgs, prefix = " * ")), collapse = "\n")
    }
    mstopOrPush(res = msgs, v_name = .var.name, collection = add)
  } else {
    for (i in seq_along(dots)) {
      val = eval(dots[[i]], envir = env)
      if (!isTRUE(val)) {
        if (is.null(.var.name))
          .var.name = as.character(dots[[i]])[2L]
        mstopOrPush(res = val, v_name = .var.name, collection = add)
      }
    }
  }
  invisible(TRUE)
}

# Error handling in assert()
#
# Internal helper function to handle errors in assert().
# @param res [character(1)}]\cr
#   error message
# @param v_name [\code{character}]\cr
#   Name(s) of the variable(s) whose assertion failed.
# @param collection [\code{AssertCollection} | \code{NULL}]\cr
#   See AssertCollection.
# @return mstopOrPush() throws an exception by calling
#   mstop() if 'collection' is NULL, or
#   pushes the error message to the collection otherwise.
# @keywords internal
mstopOrPush = function(res, v_name, collection = NULL) {
  if (!is.null(collection)) {
    v_name = sort(unique(v_name))
    prefix =
      if (length(v_name) > 1L) {
        sprintf(
          "Variables %s",
          paste0(shQuote(v_name), collapse = ", ")
        )
      } else {
        sprintf("Variable '%s'", v_name)
      }
    collection$push(sprintf("%s: %s.", prefix, res))
  } else if (length(v_name) > 1L) {
    mstop("Assertion failed. %s", res)
  } else {
    mstop("Assertion on '%s' failed: %s.", v_name, res)
  }
}
