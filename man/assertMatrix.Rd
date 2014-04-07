\name{assertMatrix}
\alias{asMatrix}
\alias{assertMatrix}
\alias{isMatrix}
\title{Check if an argument is a matrix}
\usage{
assertMatrix(x, min.rows, min.cols, nrows, ncols, row.names = "any",
  col.names = "any", .var.name)

isMatrix(x, min.rows, min.cols, nrows, ncols, row.names = "any",
  col.names = "any")

asMatrix(x, min.rows, min.cols, nrows, ncols, row.names = "any",
  col.names = "any", .var.name)
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
  names. Default is \dQuote{any} (no check).  See
  \code{\link{isNamed}} for possible values.}

  \item{col.names}{[\code{logical(1)}]\cr Check for column
  names. Default is \dQuote{any} (no check).  See
  \code{\link{isNamed}} for possible values.}

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

