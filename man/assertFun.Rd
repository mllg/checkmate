\name{assertFun}
\alias{asFun}
\alias{assertFun}
\alias{isFun}
\title{Check or assert an argument to be a function}
\usage{
assertFun(x, args, ordered = FALSE, .var.name)

isFun(x, args, ordered = FALSE)

asFun(x, args, ordered = FALSE, .var.name)
}
\arguments{
  \item{x}{[\code{ANY}]\cr Object to check.}

  \item{.var.name}{[\code{logical(1)}]\cr Argument name to
  print in error message. If missing, the name of \code{x}
  will be retrieved via \code{\link[base]{substitute}}.}

  \item{args}{[\code{character}]\cr Expected formal
  arguments.}

  \item{ordered}{[\code{logical(1)}]\cr Flag whether the
  arguments provided in \code{args} must be the first
  arguments of the function and occur in the given order.
  Default is \code{FALSE}.}
}
\value{
Depending on the prefix: \describe{
\item{\code{isFun}:}{Single logical value indicating
success.} \item{\code{assertFun}:}{\code{TRUE} on success.
An exception is thrown otherwise.} \item{\code{asFun}:}{The
(possibly converted) object itself on success. An exception
is thrown otherwise.} }
}
\description{
Check or assert an argument to be a function
}

