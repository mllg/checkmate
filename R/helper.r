makeAssertion = function(msg, var.name) {
  # FIXME test default for var.name
  if (!isTRUE(msg))
    mstop("Assertion on '%s' failed: %s", var.name, msg, n = 1L)
  invisible(TRUE)
}

# getter for variable name
vname = function(x, var.name, n = 1L) {
  if (!missing(var.name))
    return(var.name)
  deparse(substitute(x, parent.frame(n)))
}

# qassert and qassertr message helper
qamsg = function(x, msg, vname, recursive=FALSE) {
  if (isTRUE(msg))
    return(invisible(TRUE))

  if (length(msg) > 1L)
    msg = collapse(c("One of the following must apply:", strwrap(msg, prefix = " * ")))
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
  mstop("Assertion on '%s'%s failed: %s", vname, item, msg, n = 1L)
}

"%and%" = function(lhs, rhs) {
  if (isTRUE(lhs)) rhs else lhs
}

collapse = function(x, sep = ",") {
  paste0(x, collapse = sep)
}

"%nin%" = function(x, y) {
  match(x, y, nomatch = 0L) == 0L
}

allMissingAtomic = function(x) {
  is.atomic(x) && allMissing(x)
}

mstop = function(msg, ..., n = 0L) {
  stop(simpleError(sprintf(msg, ...), call = sys.call(n + 1L)))
}
