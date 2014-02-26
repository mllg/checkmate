\name{isIntegerish}
\alias{isIntegerish}
\title{Checks if an object is convertible to an integer.}
\usage{
isIntegerish(x, tolerance = .Machine$double.eps^0.5)
}
\arguments{
  \item{x}{[\code{ANY}]\cr Object to check.}

  \item{tolerance}{[\code{double(1)}]\cr Numerical
  tolerance to check if a double can be converted.  Default
  is \code{sqrt(.Machine$double.eps)}.}
}
\description{
Checks if an object is convertible to an integer.
}

