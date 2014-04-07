# getter for variable name
vname = function(x, var.name, n = 1L) {
  if (!missing(var.name))
    return(var.name)
  deparse(substitute(x, parent.frame(n)))
}

# assert* message helper
amsg = function(msg, ...) {
  if (!isTRUE(msg))
    stop(simpleError(sprintf(msg, ...), call = sys.call(1L)))
  invisible(TRUE)
}

# qassert and qassertr message helper
qamsg = function(x, msg, vname, recursive=FALSE) {
  if (!isTRUE(msg)) {
    if (length(msg) > 1L)
      msg = paste(c("One of the following must apply:", strwrap(msg, prefix = " * ")), collapse = "\n")

    if (recursive) {
      pos = attr(msg, "pos")
      if (isNamed(x)) {
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
  invisible(TRUE)
}
