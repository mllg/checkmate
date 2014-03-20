checkFlag = function(x) {
  length(x) == 1L && is.logical(x) && !is.na(x)
}

assertFlag = function(x) {
  if (!checkFlag(x))
    amsg("'%s' must be a flag", deparse(substitute(x)))
  invisible(TRUE)
}
