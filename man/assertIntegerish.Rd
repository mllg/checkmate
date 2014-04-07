\name{assertIntegerish}
\alias{asIntegerish}
\alias{assertIntegerish}
\alias{isIntegerish}
\title{Checks if an object is convertible to an integer.}
\usage{
assertIntegerish(x, tol = .Machine$double.eps^0.5, ..., .var.name)

isIntegerish(x, tol = .Machine$double.eps^0.5, ...)

asIntegerish(x, tol = .Machine$double.eps^0.5, ..., .var.name)
}
\arguments{
  \item{x}{[\code{ANY}]\cr Object to check.}

  \item{.var.name}{[\code{logical(1)}]\cr Argument name to
  print in error message. If missing, the name of \code{x}
  will be retrieved via \code{\link[base]{substitute}}.}

  \item{tol}{[\code{double(1)}]\cr Numerical tolerance used
  to check if a double can be converted.  Default is
  \code{sqrt(.Machine$double.eps)}.}

  \item{...}{[ANY]\cr Additional parameters used in a call
  of \code{\link{isVector}} or \code{\link{assertVector}}.}
}
\value{
Depending on the prefix: \describe{
\item{\code{isIntegerish}:}{Single logical value indicating
success.} \item{\code{assertIntegerish}:}{\code{TRUE} on
success. An exception is thrown otherwise.}
\item{\code{asIntegerish}:}{The (possibly converted) object
itself on success. An exception is thrown otherwise.} }
}
\description{
Checks if an object is convertible to an integer.
}
\seealso{
Other basetypes: \code{\link{asCharacter}},
\code{\link{assertCharacter}}, \code{\link{isCharacter}};
\code{\link{asInteger}}, \code{\link{assertInteger}},
\code{\link{isInteger}}; \code{\link{asList}},
\code{\link{assertList}}, \code{\link{isList}};
\code{\link{asMatrix}}, \code{\link{assertMatrix}},
\code{\link{isMatrix}}; \code{\link{asNumeric}},
\code{\link{assertNumeric}}, \code{\link{isNumeric}}
}

