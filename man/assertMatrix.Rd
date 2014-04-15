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

  \item{.var.name}{[\code{logical(1)}]\cr Argument name to
  print in error message. If missing, the name of \code{x}
  will be retrieved via \code{\link[base]{substitute}}.}

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
}
\value{
Depending on the prefix: \describe{
\item{\code{isMatrix}:}{Single logical value indicating
success.} \item{\code{assertMatrix}:}{\code{TRUE} on
success. An exception is thrown otherwise.}
\item{\code{asMatrix}:}{The (possibly converted) object
itself on success. An exception is thrown otherwise.} }
}
\description{
Check if an argument is a matrix
}
\seealso{
Other basetypes: \code{\link{asCharacter}},
\code{\link{assertCharacter}}, \code{\link{isCharacter}};
\code{\link{asDataFrame}}, \code{\link{assertDataFrame}},
\code{\link{isDataFrame}}; \code{\link{asIntegerish}},
\code{\link{assertIntegerish}}, \code{\link{isIntegerish}};
\code{\link{asInteger}}, \code{\link{assertInteger}},
\code{\link{isInteger}}; \code{\link{asList}},
\code{\link{assertList}}, \code{\link{isList}};
\code{\link{asLogical}}, \code{\link{assertLogical}},
\code{\link{isLogical}}; \code{\link{asNumeric}},
\code{\link{assertNumeric}}, \code{\link{isNumeric}}
}

