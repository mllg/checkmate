\name{checkIntegerish}
\alias{assertIntegerish}
\alias{checkIntegerish}
\title{Checks if an object is convertible to an integer.}
\usage{
checkIntegerish(x, tol = .Machine$double.eps^0.5, ...)

assertIntegerish(x, tol = .Machine$double.eps^0.5, ...)
}
\arguments{
  \item{x}{[\code{ANY}]\cr Object to check.}

  \item{tol}{[\code{double(1)}]\cr Numerical tolerance used
  to check if a double can be converted.  Default is
  \code{sqrt(.Machine$double.eps)}.}

  \item{...}{[ANY]\cr Additional parameters used in a call
  of \code{\link{checkVector}} or
  \code{\link{assertVector}}.}
}
\value{
[\code{logical(1)}] Returns \code{TRUE} on success.  Throws
an exception on failure for assertion.
}
\description{
Checks if an object is convertible to an integer.
}

