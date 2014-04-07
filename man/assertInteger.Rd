\name{assertInteger}
\alias{asInteger}
\alias{assertInteger}
\alias{isInteger}
\title{Checks if an argument is an integer}
\usage{
assertInteger(x, lower, upper, ..., .var.name)

isInteger(x, lower, upper, ...)

asInteger(x, ..., .var.name)
}
\arguments{
  \item{x}{[\code{ANY}]\cr Object to check.}

  \item{.var.name}{[\code{logical(1)}]\cr Argument name to
  print in error message. If missing, the name of \code{x}
  will be retrieved via \code{\link[base]{substitute}}.}

  \item{lower}{[\code{numeric(1)}]\cr Lower value all
  elements of \code{x} must be greater than.}

  \item{upper}{[\code{numeric(1)}]\cr Upper value all
  elements of \code{x} must be lower than.}

  \item{...}{[ANY]\cr Additional parameters used in a call
  of \code{\link{isVector}} or \code{\link{assertVector}}.}
}
\value{
Depending on the prefix: \describe{
\item{\code{isInteger}:}{Single logical value indicating
success.} \item{\code{assertInteger}:}{\code{TRUE} on
success. An exception is thrown otherwise.}
\item{\code{asInteger}:}{The (possibly converted) object
itself on success. An exception is thrown otherwise.} }
}
\description{
Checks if an argument is an integer
}
\seealso{
Other basetypes: \code{\link{asIntegerish}},
\code{\link{assertIntegerish}}, \code{\link{isIntegerish}};
\code{\link{asList}}, \code{\link{assertList}},
\code{\link{isList}}; \code{\link{asMatrix}},
\code{\link{assertMatrix}}, \code{\link{isMatrix}};
\code{\link{asNumeric}}, \code{\link{assertNumeric}},
\code{\link{isNumeric}}; \code{\link{asString}},
\code{\link{assertString}}, \code{\link{isString}}
}

