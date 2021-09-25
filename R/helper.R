mstop = function(msg, ..., call. = NULL) {
  stop(simpleError(sprintf(msg, ...), call.))
}

"%and%" = function(lhs, rhs) {
  if (isTRUE(lhs)) rhs else lhs
}

"%nin%" = function(x, y) {
  !match(x, y, nomatch = 0L)
}

convertCamelCase = function(x) {
  tolower(gsub("((?<=[a-z0-9])[A-Z]|(?!^)[A-Z](?=[a-z]))", "_\\1", x, perl = TRUE))
}

#' @useDynLib checkmate c_guess_type
guessType = function(x) {
  .Call(c_guess_type, x)
}

isSameType = function(x, y) {
  identical(typeof(x), typeof(y)) || (is.numeric(x) && is.numeric(y))
}

array_collapse = function(x) {
  if (length(x) == 0L)
    return("[]")
  sprintf("['%s']", paste0(x, collapse = "','"))
}

capitalize = function(x) {
  substr(x, 1L, 1L) = toupper(substr(x, 1L, 1L))
  x
}

set_collapse = function(x) {
  if (length(x) == 0L)
    return("{}")
  sprintf("{'%s'}", paste0(unique(x), collapse = "','"))
}

set_msg = function(msg, what, ...) {
  if (is.null(what)) {
    sprintf(capitalize(msg), ...)
  } else {
    paste(capitalize(what), sprintf(msg, ...))
  }
}

check_subset_internal = function(x, choices, match, what = NULL) {
  qassert(choices, "a")
  if (length(choices) == 0L) {
    if (length(x) == 0L)
      return(TRUE)
    return(set_msg("must be a subset of the empty set, i.e. also empty", what))
  }

  if (!is.null(x)) {
    if (!isSameType(x, choices) && !allMissing(x)) {
      return(set_msg("must be a subset of %s, but has different type", what, set_collapse(choices)))
    }

    ii = match(x, choices)
    if (anyMissing(ii)) {
      return(set_msg(
        "must be a subset of %s, but has additional elements %s",
        what, set_collapse(choices), set_collapse(x[is.na(ii)])
      ))
    }
  }

  return(TRUE)
}

check_set_equal_internal = function(x, y, match, what = NULL) {
  if ((!isSameType(x, y) && !allMissing(x))) {
    return(set_msg("Must be setequal to %s, but has different type",
        what, set_collapse(y)))
  }

  ii = match(x, y)
  if (anyMissing(ii)) {
    return(set_msg("must be a permutation of set %s, but has extra elements %s",
        what, set_collapse(y), set_collapse(x[is.na(ii)])
    ))
  }

  ii = match(y, x)
  if (anyMissing(ii)) {
    return(set_msg("must be a set equal to %s, but is missing elements %s",
        what, set_collapse(y), set_collapse(y[is.na(ii)])
    ))
  }

  return(TRUE)
}

check_disjunct_internal = function(x, y, match, what = NULL) {
  if (length(x) == 0L || length(y) == 0L) {
    return(TRUE)
  }

  ii = match(x, y, 0L) > 0L
  if (any(ii)) {
    return(set_msg("must be disjunct from %s, but has elements %s",
      what,
      set_collapse(y),
      set_collapse(x[ii])
    ))
  }

  return(TRUE)
}
