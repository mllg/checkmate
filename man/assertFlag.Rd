\name{assertFlag}
\alias{asFlag}
\alias{assertFlag}
\alias{isFlag}
\title{Checks if an argument is a flag}
\usage{
assertFlag(x, na.ok = FALSE, .var.name)

isFlag(x, na.ok = FALSE)

asFlag(x, na.ok = FALSE, .var.name)
}
\arguments{
  \item{x}{[\code{ANY}]\cr Object to check.}

  \item{na.ok}{[\code{logical(1)}]\cr Are missing values
  allowed? Default is \code{FALSE}.}

  \item{.var.name}{[\code{logical(1)}]\cr Argument name to
  print in error message. If missing, the name of \code{x}
  will be retrieved via \code{\link[base]{substitute}}.}
}
\value{
[\code{logical(1)}] Returns \code{TRUE} on success.  Throws
an exception on failure for assertion.
}
\description{
A flag a a single logical value which is not missing.
}

