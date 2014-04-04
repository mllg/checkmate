\name{assertList}
\alias{assertList}
\alias{checkList}
\title{Checks if an argument is a list}
\usage{
assertList(x, ..., .var.name)

checkList(x, ...)
}
\arguments{
  \item{x}{[\code{ANY}]\cr Object to check.}

  \item{...}{[ANY]\cr Additional parameters used in a call
  of \code{\link{checkVector}} or
  \code{\link{assertVector}}.}

  \item{.var.name}{[\code{logical(1)}]\cr Argument name to
  print in error message. If missing, the name of \code{x}
  will be retrieved via \code{\link[base]{substitute}}.}
}
\value{
[\code{logical(1)}] Returns \code{TRUE} on success.  Throws
an exception on failure for assertion.
}
\description{
Checks if an argument is a list
}

