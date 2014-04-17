\name{assertDataFrame}
\alias{asDataFrame}
\alias{assertDataFrame}
\alias{isDataFrame}
\title{Check if an argument is a data frame}
\usage{
assertDataFrame(x, types = character(0L), min.rows, min.cols, nrows, ncols,
  row.names = "any", col.names = "any", .var.name)

isDataFrame(x, types = character(0L), min.rows, min.cols, nrows, ncols,
  row.names = "any", col.names = "any")

asDataFrame(x, types = character(0L), min.rows, min.cols, nrows, ncols,
  row.names = "any", col.names = "any", .var.name)
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

  \item{types}{[\code{character}]\cr Restrict elements to
  be atomic. Tests for \dQuote{logical}, \dQuote{integer},
  \dQuote{double}, \dQuote{numeric}, \dQuote{character},
  \dQuote{factor} or \dQuote{NULL}.  Defaults to
  \code{character(0)} (no type check).}
}
\value{
Depending on the prefix: \describe{
\item{\code{isDataFrame}:}{Single logical value indicating
success.} \item{\code{assertDataFrame}:}{\code{TRUE} on
success. An exception is thrown otherwise.}
\item{\code{asDataFrame}:}{The (possibly converted) object
itself on success. An exception is thrown otherwise.} }
}
\description{
Check if an argument is a data frame
}
\seealso{
Other basetypes: \code{\link{asCharacter}},
\code{\link{assertCharacter}}, \code{\link{isCharacter}};
\code{\link{asFactor}}, \code{\link{assertFactor}},
\code{\link{isFactor}}; \code{\link{asIntegerish}},
\code{\link{assertIntegerish}}, \code{\link{isIntegerish}};
\code{\link{asInteger}}, \code{\link{assertInteger}},
\code{\link{isInteger}}; \code{\link{asList}},
\code{\link{assertList}}, \code{\link{isList}};
\code{\link{asLogical}}, \code{\link{assertLogical}},
\code{\link{isLogical}}; \code{\link{asMatrix}},
\code{\link{assertMatrix}}, \code{\link{isMatrix}};
\code{\link{asNumeric}}, \code{\link{assertNumeric}},
\code{\link{isNumeric}}
}

