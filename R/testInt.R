checkInt = function(x, na.ok=TRUE, len, min.len, max.len, lower, upper) {
  is.integer(x) && isTRUE(testNumAttr(x, na.ok, len, min.len, max.len, lower, upper))
}

assertInt = function(x, na.ok=TRUE, len, min.len, max.len, lower, upper) {
  msg = if (is.integer(x))
    testNumAttr(x, na.ok, len, min.len, max.len, lower, upper)
  else
    "'%s' must be integer"
  amsg(msg, deparse(substitute(x)))
}
