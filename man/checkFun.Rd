\name{checkFun}
\alias{assertFun}
\alias{checkFun}
\title{Check or assert an argument to be a function}
\usage{
checkFun(fun, args, ordered = FALSE)

assertFun(fun, args, ordered = FALSE)
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
}
\value{
[\code{logical(1)}] Returns \code{TRUE} on success.  Throws
an exception on failure for assertion.
}
\description{
Check or assert an argument to be a function
}

