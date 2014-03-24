\name{checkNamed}
\alias{assertNamed}
\alias{checkNamed}
\title{Check or assert that an argument is named}
\usage{
checkNamed(x, dups.ok = TRUE, strict = FALSE)

assertNamed(x, dups.ok = TRUE, strict = FALSE)
}
\arguments{
  \item{x}{[ANY]\cr Object to check.}

  \item{dups.ok}{[logical(1)]\cr Are duplicated names okay?
  Default is \code{TRUE}.}

  \item{strict}{[logical(1)]\cr Enables a check for
  compability with R's variable naming rules.  Default is
  \code{FALSE}.}
}
\value{
[\code{logical(1)}] Returns \code{TRUE} on success.  Throws
an exception on failure for assertion.
}
\description{
Check or assert that an argument is named
}

