\name{allMissing}
\alias{allMissing}
\alias{anyMissing}
\title{Checks if an object contains missing values}
\usage{
allMissing(x)

anyMissing(x)
}
\arguments{
  \item{x}{[\code{ANY}]\cr Object to check.}
}
\value{
[\code{logical(1)}] Returns \code{TRUE} if any
(\code{anyMissing}) or all (\code{allMissing}) elements of
\code{x} are missing (see details), \code{FALSE} otherwise.
}
\description{
Supported are atomic types (see
\code{\link[base]{is.atomic}}), lists and data frames.
Missingness is defined as \code{NA} or \code{NaN} for
atomics and \code{NULL} for lists.
}
\examples{
anyMissing(c(1, NA))
 allMissing(c(1, NA))
 anyMissing(NA)
 allMissing(NA)
}

