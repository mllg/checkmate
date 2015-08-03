#' Collect multiple assertions
#'
#' @param collection [\code{AssertCollection}]\cr
#'  Object of type \dQuote{AssertCollection} (constructed via \code{makeAssertCollection}).
#' @param context [\code{character(1)}]\cr
#'  Contextual information for the reporter. Will be printed as first line before
#' @description
#' The function \code{makeAssertCollection()} returns a simple stack-like
#' closure you can pass to all functions of the \code{assert*}-family.
#' All messages get collected and can be reported with \code{reportAssertions()}.
#' Alternatively, you can easily write your own report function. The example
#' on how to push custom messages or retrieve all stored messages.
#' @return \code{makeAssertCollection()} returns an object of class \dQuote{AssertCollection} and
#'  \code{reportCollection} returns invisibly \code{TRUE} if no error is thrown (i.e., no message was
#'  collected).
#' @aliases AssertCollection
#' @export
#' @examples
#' coll = makeAssertCollection()
#' x = "a"
#' assertNumeric(x, push = coll)
#' print(coll$empty())
#' coll$push("Custom error message")
#' print(coll$getMessages())
#' print(coll$getVarNames())
#' \dontrun{
#'   reportAssertions(coll)
#' }
makeAssertCollection = function() {
  vnames = character(0L)
  msgs = character(0L)
  setClasses(list(
    push = function(msg, vname) { msgs <<- c(msgs, msg); vnames <<- c(vnames, vname) },
    getVarNames = function() vnames,
    getMessages = function() msgs,
    empty = function() length(msgs) == 0L
  ), "AssertCollection")
}

#' @export
print.AssertCollection = function(x, ...) {
  cat(sprintf("Collection of %i assertions.\n", length(x$getMessages())))
  cat("Methods: push(), get() and empty().\n")
}

#' @export
#' @rdname makeAssertCollection
reportAssertions = function(collection) {
  if (!collection$empty()) {
    msgs = collection$getMessages()
    vnames = collection$getVarNames()
    msg = sprintf("%i assertions failed:", length(msgs))
    stop(simpleError(collapse(c(msg, strwrap(sprintf("Variable '%s': %s", vnames, msgs), prefix = " * ")), "\n"), call = sys.call(1L)))
  }
  invisible(NULL)
}
