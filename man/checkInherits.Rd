\name{checkInherits}
\alias{assertInherits}
\alias{checkInherits}
\title{Checks argument inheritance}
\usage{
checkInherits(x, classes)

assertInherits(x, classes)
}
\arguments{
  \item{x}{[\code{ANY}]\cr Object to check.}

  \item{classes}{[\code{character}]\cr Class names to check
  for inheritance.}
}
\value{
[\code{logical(1)}] Returns \code{TRUE} if \code{x}
inherits from all \code{classes}.  Throws an exception on
failure for assertion.
}
\description{
Checks argument inheritance
}

