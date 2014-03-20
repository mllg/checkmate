\name{checkFlag}
\alias{assertFlag}
\alias{checkFlag}
\title{Checks if an argument is a flag}
\usage{
checkFlag(x)

assertFlag(x)
}
\arguments{
  \item{x}{[\code{ANY}]\cr Object to check.}
}
\value{
[\code{logical(1)}] Returns \code{TRUE} on success.  Throws
an exception on failure for assertion.
}
\description{
A flag a a single logical value which is not missing.
}

