\name{checkNum}
\alias{assertNum}
\alias{checkNum}
\title{Checks if an argument is a numeric}
\usage{
checkNum(x, na.ok = TRUE, len, min.len, max.len, lower, upper)

assertNum(x, na.ok = TRUE, len, min.len, max.len, lower, upper)
}
\arguments{
  \item{x}{[\code{ANY}]\cr Object to check.}

  \item{na.ok}{[\code{logical(1)}]\cr Are missing values
  allowed? Default is \code{TRUE}.}

  \item{len}{[\code{integer(1)}]\cr Exact expected length
  of \code{x}.}

  \item{min.len}{[\code{integer(1)}]\cr Minimal length of
  \code{x}.}

  \item{max.len}{[\code{integer(1)}]\cr Maximal length of
  \code{x}.}

  \item{lower}{[\code{numeric(1)}]\cr Lower value all
  elements of \code{x} must be greater than.}

  \item{upper}{[\code{numeric(1)}]\cr Upper value all
  elements of \code{x} must be lower than.}
}
\value{
[\code{logical(1)}] Returns \code{TRUE} on success.  Throws
an exception on failure for assertion.
}
\description{
Checks if an argument is a numeric
}

