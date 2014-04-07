\name{assertList}
\alias{asList}
\alias{assertList}
\alias{isList}
\title{Checks if an argument is a list}
\usage{
assertList(x, ..., .var.name)

isList(x, ...)

asList(x, ..., .var.name)
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
\item{\code{isList}:}{Single logical value indicating
success.} \item{\code{assertList}:}{\code{TRUE} on success.
An exception is thrown otherwise.}
\item{\code{asList}:}{The (possibly converted) object
itself on success. An exception is thrown otherwise.} }
}
\description{
Checks if an argument is a list
}
\seealso{
Other basetypes: \code{\link{asIntegerish}},
\code{\link{assertIntegerish}}, \code{\link{isIntegerish}};
\code{\link{asInteger}}, \code{\link{assertInteger}},
\code{\link{isInteger}}; \code{\link{asMatrix}},
\code{\link{assertMatrix}}, \code{\link{isMatrix}};
\code{\link{asNumeric}}, \code{\link{assertNumeric}},
\code{\link{isNumeric}}; \code{\link{asString}},
\code{\link{assertString}}, \code{\link{isString}}
}

