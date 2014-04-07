\name{assertCount}
\alias{asCount}
\alias{assertCount}
\alias{isCount}
\title{Checks if an argument is a count}
\usage{
assertCount(x, .var.name)

isCount(x)

asCount(x, .var.name)
}
\arguments{
  \item{x}{[\code{ANY}]\cr Object to check.}

  \item{.var.name}{[\code{logical(1)}]\cr Argument name to
  print in error message. If missing, the name of \code{x}
  will be retrieved via \code{\link[base]{substitute}}.}
}
\value{
[\code{logical(1)}] Returns \code{TRUE} on success.  Throws
an exception on failure for assertion.
}
\description{
A count a a single integerish numeric >= 0 which is not
missing.
}

