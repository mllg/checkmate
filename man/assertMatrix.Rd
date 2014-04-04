\name{assertMatrix}
\alias{assertMatrix}
\title{Check if an argument is a matrix}
\usage{
assertMatrix(x, min.rows, min.cols, nrows, ncols, row.names = FALSE,
  col.names = FALSE, .var.name)
}
\arguments{
  \item{x}{[\code{ANY}]\cr Object to check.}

  \item{min.rows}{[\code{integer(1)}]\cr Minimum number of
  rows.}

  \item{min.cols}{[\code{integer(1)}]\cr Minimum number of
  columns.}

  \item{nrows}{[\code{integer(1)}]\cr Exact number of
  rows.}

  \item{ncols}{[\code{integer(1)}]\cr Exact number of
  columns.}

  \item{row.names}{[\code{logical(1)}]\cr Check for row
  names. Default is \code{FALSE}.}

  \item{col.names}{[\code{logical(1)}]\cr Check for column
  names. Default is \code{FALSE}.}

  \item{.var.name}{[\code{logical(1)}]\cr Argument name to
  print in error message. If missing, the name of \code{x}
  will be retrieved via \code{\link[base]{substitute}}.}
}
\value{
[\code{logical(1)}] Returns \code{TRUE} on success.  Throws
an exception on failure for assertion.
}
\description{
Check if an argument is a matrix
}

