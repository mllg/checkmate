checkBounds = function(x, lower = -Inf, upper = Inf) {
  if (is.finite(lower) && any(x < lower))
    return(sprintf("All elements of '%%s' must be >= %s", lower))
  if (is.finite(upper) && any(x > upper))
    return(sprintf("All elements of '%%s' must be <= %s", upper))
  return(TRUE)
}
