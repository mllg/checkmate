\name{assertString}
\alias{asString}
\alias{assertString}
\alias{isString}
\title{Checks if an argument is a string}
\usage{
assertString(x, pattern, ignore.case = FALSE, perl = FALSE, fixed = FALSE,
  ..., .var.name)

isString(x, pattern, ignore.case = FALSE, perl = FALSE, fixed = FALSE,
  ...)

asString(x, pattern, ignore.case = FALSE, perl = FALSE, fixed = FALSE,
  ..., .var.name)
}
\arguments{
  \item{x}{[\code{ANY}]\cr Object to check.}

  \item{.var.name}{[\code{logical(1)}]\cr Argument name to
  print in error message. If missing, the name of \code{x}
  will be retrieved via \code{\link[base]{substitute}}.}

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
  of \code{\link{isVector}} or \code{\link{assertVector}}.}
}
\value{
Depending on the prefix: \describe{
\item{\code{isString}:}{Single logical value indicating
success.} \item{\code{assertString}:}{\code{TRUE} on
success. An exception is thrown otherwise.}
\item{\code{asString}:}{The (possibly converted) object
itself on success. An exception is thrown otherwise.} }
}
\description{
Checks if an argument is a string
}
\seealso{
Other basetypes: \code{\link{asIntegerish}},
\code{\link{assertIntegerish}}, \code{\link{isIntegerish}};
\code{\link{asInteger}}, \code{\link{assertInteger}},
\code{\link{isInteger}}; \code{\link{asList}},
\code{\link{assertList}}, \code{\link{isList}};
\code{\link{asMatrix}}, \code{\link{assertMatrix}},
\code{\link{isMatrix}}; \code{\link{asNumeric}},
\code{\link{assertNumeric}}, \code{\link{isNumeric}}
}

