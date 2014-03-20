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
    stop(simpleError(msg, call=sys.call(1L)))
  }
  invisible(TRUE)
}

testNumAttr = function(x, na.ok, len, min.len, max.len, lower, upper) {
  if (assertFlag(na.ok) && !na.ok && anyMissing(x))
    return("'%s' contains missing values")
  if (!missing(min.len) && qassert(min.len, "I1") && length(x) < min.len)
    return(sprintf("'%%s' must have length >= %i", min.len))
  if (!missing(max.len) && qassert(max.len, ("I1") && length(x) > max.len))
    return(sprintf("'%%s' must have length <= %i", max.len))
  if (!missing(len) && qassert(len, "I1") && length(x) != len)
    return(sprintf("'%%s' must have length %i", len))
  if (!missing(lower) && qassert("N1") && any(x < lower))
    return(sprintf("All elements of '%%s' must be >= %s", lower))
  if (!missing(upper) && qassert("N1") && any(x > upper))
    return(sprintf("All elements of '%%s' must be <= %s", upper))
  return(TRUE)
}
