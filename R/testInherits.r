testInherits = function(x, classes) {
  qassert(classes, "S")
  w = which(inherits(x, classes, TRUE) == 0L)
  if (length(w) > 0L)
    return(sprintf("'%s' must be of class '%s'", classes[w[1L]]))
  return(TRUE)
}

checkInherits = function(x, classes) {
  isTRUE(testInherits(x, classes))
}

assertInherits = function(x, classes) {
  amsg(testInherits(x, classes))
}
