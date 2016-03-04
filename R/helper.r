vname = function(x, var.name) {
  if (!is.null(var.name))
    return(var.name)
  collapse(deparse(substitute(x, parent.frame(2L)), width.cutoff = 500), "\n")
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

  if (is.null(vname))
    vname = collapse(deparse(substitute(x, parent.frame(1L)), width.cutoff = 500), "\n")
  sprintf("Assertion on '%s'%s failed. %s", vname, item, msg)
}

"%and%" = function(lhs, rhs) {
  if (identical(lhs, TRUE)) rhs else lhs
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

convertCamelCase = function(x) {
  tolower(gsub("((?<=[a-z0-9])[A-Z]|(?!^)[A-Z](?=[a-z]))", "_\\1", x, perl = TRUE))
}
