# TODO: finalize
check_elementOf = function(x, choices) {
  qassert(x, "a1")
  qassert(choices, "a+")
  if (x %nin% choices)
    return(sprintf("'%%s' is '%s', but should be element of '%s'", collapse(choices, "','")))
  return(TRUE)
}

# TODO: finalize
check_subset = function(x, choices) {
  qassert(x, "a1")
  qassert(choices, "a+")
  not.ok = which.first(x %nin% choices)
  if (length(not.ok) > 0L)
    return(sprintf("'%%s' has element '%s', but all elements should be element of set: '%s'", x[not.ok], collapse(choices, "','")))
  return(TRUE)
}
