\name{checkString}
\alias{checkString}
\title{Checks if an argument is a string}
\usage{
checkString(x, pattern, ignore.case = FALSE, perl = FALSE, fixed = FALSE,
  ...)
}
\arguments{
  \item{x}{[\code{ANY}]\cr Object to check.}

  \item{pattern}{[\code{character(1L)}]\cr Regular
  expression as used to use in \code{\link[base]{grepl}}.
  All elements of \code{x} must comply to this pattern.}

  \item{ignore.case}{[\code{logical(1)}]\cr See
  \code{\link[base]{grepl}}. Default is \code{FALSE}.}

  \item{perl}{[\code{logical(1)}]\cr See
  \code{\link[base]{grepl}}. Default is \code{FALSE}.}

  \item{fixed}{[\code{logical(1)}]\cr See
  \code{\link[base]{grepl}}. Default is \code{FALSE}.}

  \item{...}{[ANY]\cr Additional parameters used in a call
  of \code{\link{checkVector}} or
  \code{\link{checkVector}}.}
}
\value{
[\code{logical(1)}] Returns \code{TRUE} on success.  Throws
an exception on failure for assertion.
}
\description{
Checks if an argument is a string
}

