# getter for variable name
vname = function(x, var.name, n = 1L) {
  if (!missing(var.name))
    return(var.name)
  deparse(substitute(x, parent.frame(n)))
}

vlapply = function(x, fun, ..., use.names = TRUE) {
  vapply(X = x, FUN = fun, USE.NAMES = use.names, FUN.VALUE = NA, ...)
}

# assert* message helper
amsg = function(msg, ...) {
  if (!isTRUE(msg))
    stop(simpleError(sprintf(msg, ...), call=sys.call(1L)))
  invisible(TRUE)
}

# qassert and qassertr message helper
qamsg = function(msg, vname) {
  if (!isTRUE(msg)) {
    if (length(msg) > 1L)
      msg = paste(c("One of the following must apply:", strwrap(msg, prefix = " * ")), collapse = "\n")

    msg = sprintf("Error checking argument '%s': %s", vname, msg)
    stop(simpleError(msg, call = sys.call(1L)))
  }
  invisible(TRUE)
}
