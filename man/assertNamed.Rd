\name{assertNamed}
\alias{asNamed}
\alias{assertNamed}
\alias{isNamed}
\title{Check or assert that an argument is named}
\usage{
assertNamed(x, type = "named", .var.name)

isNamed(x, type = "named")

asNamed(x, type = "named", .var.name)
}
\arguments{
  \item{x}{[\code{ANY}]\cr Object to check.}

  \item{.var.name}{[\code{logical(1)}]\cr Argument name to
  print in error message. If missing, the name of \code{x}
  will be retrieved via \code{\link[base]{substitute}}.}

  \item{type}{[character(1)]\cr Select the check(s) to
  perform.  \dQuote{unnamed} checks \code{x} to be unnamed.
  \dQuote{named} (default) checks \code{x} to be named,
  this includes names to be not \code{NA} or emtpy
  (\code{""}).  \dQuote{unique} additionally tests for
  non-duplicated names and \code{strict} tests the names to
  comply to R's variable naming rules on top of
  \dQuote{unique}.  Note that for zero-length \code{x}
  every name check evalutes to \code{TRUE}.}
}
\value{
Depending on the prefix: \describe{
\item{\code{isNamed}:}{Single logical value indicating
success.} \item{\code{assertNamed}:}{\code{TRUE} on
success. An exception is thrown otherwise.}
\item{\code{asNamed}:}{The (possibly converted) object
itself on success. An exception is thrown otherwise.} }
}
\description{
Check or assert that an argument is named
}

