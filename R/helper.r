makeAssertion = function(msg, var.name) {
  if (!isTRUE(msg))
    stop(simpleError(sprintf(msg, var.name), call = sys.call(1L)))
  invisible(TRUE)
}

makeTest = function(msg) {
  isTRUE(msg)
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
    if (test(x, "named")) {
      item = sprintf(", element '%s' (%i)", names(x)[pos], pos)
    } else {
      item = sprintf(", element %i", pos)
    }
  } else {
    item = ""
  }
  msg = sprintf("Error checking argument '%s'%s: %s", vname, item, msg)
  stop(simpleError(msg, call = sys.call(1L)))
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

mustBeClass = function(cl)
  sprintf("'%%s' must be of class '%s'", cl)

mustLength = function(len) {
  sprintf("'%%s' must have length %i", len)
}
