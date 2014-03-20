checkNum = function(x, na.ok=TRUE, len, min.len, max.len, lower, upper) {
  is.numeric(x) && isTRUE(testNumAttr(x, na.ok, len, min.len, max.len, lower, upper))
}

assertNum = function(x, na.ok=TRUE, len, min.len, max.len, lower, upper) {
  msg = if (is.numeric(x))
    testNumAttr(x, na.ok, len, min.len, max.len, lower, upper)
  else
    "'%s' must be numeric"
  amsg(msg, deparse(substitute(x)))
}
