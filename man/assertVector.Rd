\name{assertVector}
\alias{assertVector}
\alias{checkVector}
\title{Check vector properties}
\usage{
assertVector(x, na.ok = TRUE, len, min.len, max.len, names = "any",
  .var.name)

checkVector(x, na.ok = TRUE, len, min.len, max.len, names = "any")
}
\arguments{
  \item{x}{[\code{ANY}]\cr Vector to check.}

  \item{na.ok}{[\code{logical(1)}]\cr Are missing values
  allowed? Default is \code{TRUE}.}

  \item{len}{[\code{integer(1)}]\cr Exact expected length
  of \code{x}.}

  \item{min.len}{[\code{integer(1)}]\cr Minimal length of
  \code{x}.}

  \item{max.len}{[\code{integer(1)}]\cr Maximal length of
  \code{x}.}

  \item{names}{[\code{character(1)}]\cr Check for names
  attribute.  See also \code{\link{checkNamed}} for
  possible values.  Default is \dQuote{none} which performs
  no check at all.}

  \item{.var.name}{[\code{logical(1)}]\cr Argument name to
  print in error message. If missing, the name of \code{x}
  will be retrieved via \code{\link[base]{substitute}}.}
}
\value{
[\code{logical(1)}] Returns \code{TRUE} on success.  Throws
an exception on failure for assertion.
}
\description{
Check vector properties
}

