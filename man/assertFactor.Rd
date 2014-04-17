\name{assertFactor}
\alias{asFactor}
\alias{assertFactor}
\alias{isFactor}
\title{Checks if an argument is a factor}
\usage{
assertFactor(x, levels, ordered = NA, empty.levels.ok = TRUE, ...,
  .var.name)

isFactor(x, levels, ordered = NA, empty.levels.ok = TRUE, ...)

asFactor(x, levels, ordered = NA, empty.levels.ok = TRUE, ..., .var.name)
}
\arguments{
  \item{x}{[\code{ANY}]\cr Object to check.}

  \item{.var.name}{[\code{logical(1)}]\cr Argument name to
  print in error message. If missing, the name of \code{x}
  will be retrieved via \code{\link[base]{substitute}}.}

  \item{levels}{[\code{character}]\cr Vector of allowed
  factor levels.}

  \item{ordered}{[\code{logical(1)}]\cr Check for an
  ordered factor? If \code{FALSE}, checks explicitly for an
  unordered factor.  Default is \code{NA} which disables
  this check.}

  \item{empty.levels.ok}{[\code{logical(1)}]\cr Are empty
  levels allowed?  Default is \code{TRUE}.}

  \item{...}{[ANY]\cr Additional parameters used in a call
  of \code{\link{isVector}} or \code{\link{assertVector}}.}
}
\value{
Depending on the prefix: \describe{
\item{\code{isFactor}:}{Single logical value indicating
success.} \item{\code{assertFactor}:}{\code{TRUE} on
success. An exception is thrown otherwise.}
\item{\code{asFactor}:}{The (possibly converted) object
itself on success. An exception is thrown otherwise.} }
}
\description{
Checks if an argument is a factor
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
\code{\link{isLogical}}; \code{\link{asMatrix}},
\code{\link{assertMatrix}}, \code{\link{isMatrix}};
\code{\link{asNumeric}}, \code{\link{assertNumeric}},
\code{\link{isNumeric}}
}

