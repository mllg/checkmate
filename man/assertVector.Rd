\name{assertVector}
\alias{asVector}
\alias{assertVector}
\alias{isVector}
\title{Check vector properties}
\usage{
assertVector(x, na.ok = TRUE, len, min.len, max.len, names = "any",
  .var.name)

isVector(x, na.ok = TRUE, len, min.len, max.len, names = "any")

asVector(x, na.ok = TRUE, len, min.len, max.len, names = "any", .var.name)
}
\arguments{
  \item{x}{[\code{ANY}]\cr Object to check.}

  \item{.var.name}{[\code{logical(1)}]\cr Argument name to
  print in error message. If missing, the name of \code{x}
  will be retrieved via \code{\link[base]{substitute}}.}

  \item{na.ok}{[\code{logical(1)}]\cr Are missing values
  allowed? Default is \code{TRUE}.}

  \item{len}{[\code{integer(1)}]\cr Exact expected length
  of \code{x}.}

  \item{min.len}{[\code{integer(1)}]\cr Minimal length of
  \code{x}.}

  \item{max.len}{[\code{integer(1)}]\cr Maximal length of
  \code{x}.}

  \item{names}{[\code{character(1)}]\cr Check for names
  attribute.  See also \code{\link{isNamed}} for possible
  values.  Default is \dQuote{none} which performs no check
  at all.}
}
\value{
Depending on the prefix: \describe{
\item{\code{isVector}:}{Single logical value indicating
success.} \item{\code{assertVector}:}{\code{TRUE} on
success. An exception is thrown otherwise.}
\item{\code{asVector}:}{The (possibly converted) object
itself on success. An exception is thrown otherwise.} }
}
\description{
Check vector properties
}

