\name{assertFun}
\alias{assertFun}
\title{Matches and checks a function's signature}
\usage{
assertFun(fun, args, ordered = FALSE)
}
\arguments{
  \item{fun}{[\code{character} or \code{function}]\cr
  Function to match or check.}

  \item{args}{[\code{character}]\cr Expected formal
  arguments.}

  \item{ordered}{[\code{logical(1)}]\cr Flag whether the
  arguments provided in \code{args} must be the first
  arguments of the function and occur in the given order.
  Default is \code{FALSE}.}
}
\value{
[\code{logical(1)}] Returns \code{TRUE} if at least one
element of \code{x} is missing (see details).
}
\description{
Matches and checks a function's signature
}

