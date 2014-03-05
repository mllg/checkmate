\name{isIntegerish}
\alias{isIntegerish}
\title{Checks if an object is convertible to an integer.}
\usage{
isIntegerish(x, tol = .Machine$double.eps^0.5)
}
\arguments{
  \item{x}{[\code{ANY}]\cr Object to check.}

  \item{tol}{[\code{double(1)}]\cr Numerical tolerance used
  to check if a double can be converted.  Default is
  \code{sqrt(.Machine$double.eps)}.}
}
\value{
[logical(1)]: \code{TRUE} if \code{x} can be converted
safely, \code{FALSE} otherwise.
}
\description{
Checks if an object is convertible to an integer.
}

