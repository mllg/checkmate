\name{checkVector}
\alias{assertVector}
\alias{checkVector}
\title{Checks vector properties}
\usage{
checkVector(x, na.ok = TRUE, len, min.len, max.len)

assertVector(x, na.ok = TRUE, len, min.len, max.len)
}
\arguments{
  \item{x}{[\code{ANY}]\cr Vector to check.}

  \item{na.ok}{[\code{logical(1)}]\cr Are missing values
  allowed? Default is \code{TRUE}.}

  \item{len}{[\code{integer(1)}]\cr Exact expected length
  of \code{x}.}

  \item{min.len}{[\code{integer(1)}]\cr Minimal length of
  \code{x}.}

  \item{max.len}{[\code{integer(1)}]\cr Maximal length of
  \code{x}.}
}
\value{
[\code{logical(1)}] Returns \code{TRUE} on success.  Throws
an exception on failure for assertion.
}
\description{
Checks vector properties
}

