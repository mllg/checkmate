\name{asInteger}
\alias{asInteger}
\title{Safely converts an object to an integer}
\usage{
asInteger(x, ..., .var.name)
}
\arguments{
  \item{x}{[\code{ANY}]\cr Object to convert.}

  \item{...}{[ANY]\cr Additional parameters used in a call
  of \code{\link{assertVector}}.}

  \item{.var.name}{[\code{logical(1)}]\cr Argument name to
  print in error message. If missing, the name of \code{x}
  will be retrieved via \code{\link[base]{substitute}}.}
}
\value{
[\code{integer}] Returns the converted object on success.
}
\description{
Supported are logical, interger and numeric types. Unlike
\code{\link[base]{as.integer}}, an exception is thrown if
\code{x} cannot be converted safely (without generating
\code{NA}s).
}

