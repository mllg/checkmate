\name{assertFun}
\alias{asFun}
\alias{assertFun}
\alias{isFun}
\title{Check or assert an argument to be a function}
\usage{
assertFun(fun, args, ordered = FALSE, .var.name)

isFun(fun, args, ordered = FALSE)

asFun(fun, args, ordered = FALSE, .var.name)
}
\arguments{
  \item{fun}{[\code{character} or \code{function}]\cr
  Function to check.}

  \item{args}{[\code{character}]\cr Expected formal
  arguments.}

  \item{ordered}{[\code{logical(1)}]\cr Flag whether the
  arguments provided in \code{args} must be the first
  arguments of the function and occur in the given order.
  Default is \code{FALSE}.}

  \item{.var.name}{[\code{logical(1)}]\cr Argument name to
  print in error message. If missing, the name of \code{x}
  will be retrieved via \code{\link[base]{substitute}}.}
}
\value{
[\code{logical(1)}] Returns \code{TRUE} on success.  Throws
an exception on failure for assertion.
}
\description{
Check or assert an argument to be a function
}

