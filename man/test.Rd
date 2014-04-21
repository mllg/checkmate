\name{test}
\alias{test}
\title{Evaluate a check function to a logical value}
\usage{
test(x, checker, ...)
}
\arguments{
  \item{x}{[ANY]\cr Object to check.}

  \item{checker}{[character(1)]\cr Name of the checker
  function without preceding \dQuote{check_}, e.g.
  \dQuote{numeric}.}

  \item{...}{[ANY]\cr Additional parameters passed down to
  \code{checker}.}
}
\value{
\code{TRUE} on success, \code{FALSE} otherwise.
}
\description{
Evaluate a check function to a logical value
}
\seealso{
Other evaluate: \code{\link{assert}}; \code{\link{pass}}
}

