\name{assertNamed}
\alias{assertNamed}
\alias{checkNamed}
\title{Check or assert that an argument is named}
\usage{
assertNamed(x, type = "existing", .var.name)

checkNamed(x, type = "existing")
}
\arguments{
  \item{x}{[\code{ANY}]\cr Object to check.}

  \item{type}{[character]\cr Select the checks to perform.
  \dQuote{off} performs no check at all.  \dQuote{unnamed}
  checks \code{x} to be unnamed.  \dQuote{existing}
  (default) checks \code{x} to be named, this includes
  names to be not \code{NA} or emtpy (\code{""}).
  \dQuote{unique} checks tests for non-duplicated names and
  \code{strict} tests the names to comply to R's variable
  naming rules.  These later three arguments can be mixed
  together.  Note that for zero-length \code{x} every name
  check is \code{TRUE}.}

  \item{.var.name}{[\code{logical(1)}]\cr Argument name to
  print in error message. If missing, the name of \code{x}
  will be retrieved via \code{\link[base]{substitute}}.}
}
\value{
[\code{logical(1)}] Returns \code{TRUE} on success.  Throws
an exception on failure for assertion.
}
\description{
Check or assert that an argument is named
}

