\name{assert}
\alias{assert}
\alias{pass}
\alias{test}
\title{Evaluate a check function}
\usage{
assert(x, checker, ..., .var.name)

test(x, checker, ...)

pass(x, checker, ..., .var.name)
}
\arguments{
  \item{x}{[ANY]\cr Object to check.}

  \item{checker}{[\code{character(1)} or
  \code{function}]\cr Either the name of a check function
  without preceding \dQuote{check_} (e.g. \dQuote{numeric}
  for \code{\link{check_numeric}}) or a function.  The
  function is expected to return \code{TRUE} for a success
  check and return a string with placeholder \dQuote{\%s}
  (see \code{\link[base]{sprintf}} for \code{.var.name}.}

  \item{...}{[ANY]\cr Additional parameters passed down to
  \code{checker}.}

  \item{.var.name}{[\code{character(1)}]\cr Phony name for
  \code{x} to use in error message.  If not provided,
  \code{x} will be substituted.}
}
\value{
See Description.
}
\description{
All functions apply the check function \code{checker} on
\code{x} but react different on the check result. Function
\code{assert} invisibly returns \code{TRUE} on success and
raises an R exeception otherwise. Function \code{check}
returns the check result as single logical value Function
\code{pass} returns \code{x} on success and raises an
exception otherwise.
}

