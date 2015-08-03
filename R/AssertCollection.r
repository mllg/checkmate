#' Collect multiple assertions
#' @name AssertCollection
#'
#' @param collection [\code{AssertCollection}]\cr
#'  Object of type \dQuote{AssertCollection} (constructed via \code{makeAssertCollection}).
#' @description
#' The function \code{makeAssertCollection()} returns a simple stack-like
#' closure you can pass to all functions of the \code{assert*}-family.
#' All messages get collected and can be reported with \code{reportAssertions()}.
#' Alternatively, you can easily write your own report function or customize the the output of
#' the report function to a certain degree.
#' See the example on how to push custom messages or retrieve all stored messages.
#' @return \code{makeAssertCollection()} returns an object of class \dQuote{AssertCollection} and
#'  \code{reportCollection} returns invisibly \code{TRUE} if no error is thrown (i.e., no message was
#'  collected).
#' @examples
#' x = "a"
#' coll = makeAssertCollection()
#'
#' print(coll$isEmpty())
#' assertNumeric(x, add = coll)
#' coll$isEmpty()
#' coll$push("Custom error message")
#' coll$getMessages()
#' \dontrun{
#'   reportAssertions(coll)
#' }
NULL

#' @export
#' @rdname AssertCollection
makeAssertCollection = function() {
  msgs = character(0L)
  setClasses(list(
    push = function(msg) msgs <<- c(msgs, msg),
    getMessages = function() msgs,
    isEmpty = function() length(msgs) == 0L
  ), "AssertCollection")
}

#' @export
print.AssertCollection = function(x, ...) {
  n = length(x$getMessages())
  if (n == 0L) {
    cat("Empty collection\n")
  } else {
    cat(sprintf("Collection of %i assertion%s.\n", n, ifelse(n > 1L, "s", "")))
  }
}

#' @export
#' @rdname AssertCollection
reportAssertions = function(collection) {
  assertClass(collection, "AssertCollection")
  if (!collection$isEmpty()) {
    msgs = collection$getMessages()
    context = "%i assertions failed:"
    err = c(sprintf(context, length(msgs)), strwrap(msgs, prefix = " * "))
    stop(simpleError(collapse(err, "\n"), call = sys.call(1L)))
  }
  invisible(TRUE)
}
