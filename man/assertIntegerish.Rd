\name{assertIntegerish}
\alias{asIntegerish}
\alias{assertIntegerish}
\alias{isIntegerish}
\title{Checks if an object is convertible to an integer.}
\usage{
assertIntegerish(x, tol = .Machine$double.eps^0.5, ..., .var.name)

isIntegerish(x, tol = .Machine$double.eps^0.5, ...)

asIntegerish(x, tol = .Machine$double.eps^0.5, ..., .var.name)
}
\arguments{
  \item{x}{[\code{ANY}]\cr Object to check.}

  \item{tol}{[\code{double(1)}]\cr Numerical tolerance used
  to check if a double can be converted.  Default is
  \code{sqrt(.Machine$double.eps)}.}

  \item{...}{[ANY]\cr Additional parameters used in a call
  of \code{\link{isVector}} or \code{\link{assertVector}}.}

  \item{.var.name}{[\code{logical(1)}]\cr Argument name to
  print in error message. If missing, the name of \code{x}
  will be retrieved via \code{\link[base]{substitute}}.}
}
\value{
[\code{logical(1)}] Returns \code{TRUE} on success.  Throws
an exception on failure for assertion.
}
\description{
Checks if an object is convertible to an integer.
}

