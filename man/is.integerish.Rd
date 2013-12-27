\name{is.integerish}
\alias{is.integerish}
\title{Converts a numeric object to a integer, if possible}
\usage{
is.integerish(x, tolerance = .Machine$double.eps^0.5)
}
\arguments{
  \item{x}{[\code{ANY}]\cr Object to check.}

  \item{tolerance}{[\code{double(1)}]\cr Numerical
  tolerance to check if a double could be an integer.
  Default is \code{sqrt(.Machine$double.eps)}.}
}
\description{
Converts a numeric object to a integer, if possible
}

