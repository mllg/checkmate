\name{checkCount}
\alias{assertCount}
\alias{checkCount}
\title{Checks if an argument is a count}
\usage{
checkCount(x)

assertCount(x)
}
\arguments{
  \item{x}{[\code{ANY}]\cr Object to check.}
}
\value{
[\code{logical(1)}] Returns \code{TRUE} on success.  Throws
an exception on failure for assertion.
}
\description{
A count a a single integerish numeric which is not missing.
}

