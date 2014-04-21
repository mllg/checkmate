\name{pass}
\alias{pass}
\title{Evaluate a check function and return object on success}
\usage{
pass(x, checker, ..., .var.name)
}
\arguments{
  \item{x}{[ANY]\cr Object to check.}

  \item{checker}{[character(1)]\cr Name of the checker
  function without preceding \dQuote{check_}, e.g.
  \dQuote{numeric}.}

  \item{...}{[ANY]\cr Additional parameters passed down to
  \code{checker}.}

  \item{.var.name}{[\code{character(1)}]\cr Phony name for
  \code{x} to use in error message.  If not provided,
  \code{x} will be substituted.}
}
\value{
\code{x} on success, an exception is thrown otherwise.
}
\description{
Evaluate a check function and return object on success
}
\seealso{
Other evaluate: \code{\link{assert}}; \code{\link{test}}
}

