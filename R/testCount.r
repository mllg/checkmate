checkCount = function(x) {
  length(x) == 1L && checkIntegerish(x) && !is.na(x)
}

assertFlag = function(x) {
  if (!checkCount(x))
    amsg("'%s' must be a count", deparse(substitute(x)))
  invisible(TRUE)
}
