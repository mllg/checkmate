\name{assertLogical}
\alias{asLogical}
\alias{assertLogical}
\alias{isLogical}
\title{Checks if an argument is an logical vector}
\usage{
assertLogical(x, ..., .var.name)

isLogical(x, ...)

asLogical(x, ..., .var.name)
}
\arguments{
  \item{x}{[\code{ANY}]\cr Object to check.}

  \item{.var.name}{[\code{logical(1)}]\cr Argument name to
  print in error message. If missing, the name of \code{x}
  will be retrieved via \code{\link[base]{substitute}}.}

  \item{...}{[ANY]\cr Additional parameters used in a call
  of \code{\link{isVector}} or \code{\link{assertVector}}.}
}
\value{
Depending on the prefix: \describe{
\item{\code{isLogical}:}{Single logical value indicating
success.} \item{\code{assertLogical}:}{\code{TRUE} on
success. An exception is thrown otherwise.}
\item{\code{asLogical}:}{The (possibly converted) object
itself on success. An exception is thrown otherwise.} }
}
\description{
Checks if an argument is an logical vector
}
\seealso{
Other basetypes: \code{\link{asCharacter}},
\code{\link{assertCharacter}}, \code{\link{isCharacter}};
\code{\link{asIntegerish}}, \code{\link{assertIntegerish}},
\code{\link{isIntegerish}}; \code{\link{asInteger}},
\code{\link{assertInteger}}, \code{\link{isInteger}};
\code{\link{asList}}, \code{\link{assertList}},
\code{\link{isList}}; \code{\link{asMatrix}},
\code{\link{assertMatrix}}, \code{\link{isMatrix}};
\code{\link{asNumeric}}, \code{\link{assertNumeric}},
\code{\link{isNumeric}}
}

