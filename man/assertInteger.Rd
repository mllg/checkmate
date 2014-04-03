\name{assertInteger}
\alias{assertInteger}
\alias{checkInteger}
\title{Checks if an argument is an integer}
\usage{
assertInteger(x, lower, upper, ..., .var.name)

checkInteger(x, lower, upper, ...)
}
\arguments{
  \item{x}{[\code{ANY}]\cr Object to check.}

  \item{lower}{[\code{numeric(1)}]\cr Lower value all
  elements of \code{x} must be greater than.}

  \item{upper}{[\code{numeric(1)}]\cr Upper value all
  elements of \code{x} must be lower than.}

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
Checks if an argument is an integer
}

