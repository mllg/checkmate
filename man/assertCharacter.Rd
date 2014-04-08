\name{assertCharacter}
\alias{asCharacter}
\alias{assertCharacter}
\alias{isCharacter}
\title{Checks if an argument is a character}
\usage{
assertCharacter(x, pattern, ignore.case = FALSE, perl = FALSE,
  fixed = FALSE, min.chars = 0L, ..., .var.name)

isCharacter(x, pattern, ignore.case = FALSE, perl = FALSE, fixed = FALSE,
  min.chars = 0L, ...)

asCharacter(x, pattern, ignore.case = FALSE, perl = FALSE, fixed = FALSE,
  min.chars = 0L, ..., .var.name)
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

  \item{min.chars}{[\code{integer(1)}]\cr Minimum number of
  characters in each element of \code{x}.}

  \item{...}{[ANY]\cr Additional parameters used in a call
  of \code{\link{isVector}} or \code{\link{assertVector}}.}
}
\value{
Depending on the prefix: \describe{
\item{\code{isCharacter}:}{Single logical value indicating
success.} \item{\code{assertCharacter}:}{\code{TRUE} on
success. An exception is thrown otherwise.}
\item{\code{asCharacter}:}{The (possibly converted) object
itself on success. An exception is thrown otherwise.} }
}
\description{
Checks if an argument is a character
}
\seealso{
Other basetypes: \code{\link{asIntegerish}},
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

