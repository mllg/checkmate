vname = function(x, var.name) {
  if (!missing(var.name) && !is.null(var.name))
    return(var.name)
  collapse(deparse(substitute(x, parent.frame(1L)), width.cutoff = 500), "\n")
}

makeAssertion = function(msg, var.name, collection) {
  if (!isTRUE(msg)) {
    if (is.null(collection))
      mstop("Assertion on '%s' failed: %s", var.name, msg)
    collection$push(sprintf("Variable '%s': %s", var.name, msg))
    return(invisible(FALSE))
  }
  invisible(TRUE)
}

makeExpectation = function(res, info, label) {
  if (!requireNamespace("testthat", quietly = TRUE))
    stop("Package 'testthat' is required for 'expect_*' extensions")
  cond = function(tmp) testthat::expectation(isTRUE(res), failure_msg = res, success_msg = "all good")
  testthat::expect_that(TRUE, cond, info = info, label = label)
}

mstop = function(msg, ...) {
  stop(simpleError(sprintf(msg, ...), call = sys.call(1L)))
}

qamsg = function(x, msg, vname, recursive=FALSE) {
  if (length(msg) > 1L)
    msg = collapse(c("One of the following must apply:", strwrap(msg, prefix = " * ")), "\n")
  if (recursive) {
    pos = attr(msg, "pos")
    if (testNamed(x)) {
      item = sprintf(", element '%s' (%i),", names(x)[pos], pos)
    } else {
      item = sprintf(", element %i,", pos)
    }
  } else {
    item = ""
  }
  sprintf("Assertion on '%s'%s failed. %s", vname, item, msg)
}

"%and%" = function(lhs, rhs) {
  if (isTRUE(lhs)) rhs else lhs
}

collapse = function(x, sep = ",") {
  paste0(x, collapse = sep)
}

"%nin%" = function(x, y) {
  !match(x, y, nomatch = 0L)
}

setClasses = function(x, cl) {
  class(x) = cl
  x
}

killCamel = function(x) {
  gsub("([A-Z])", "_\\L\\1", x, perl = TRUE)
}
