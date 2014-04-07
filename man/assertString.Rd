\name{assertString}
\alias{asString}
\alias{assertString}
\alias{isString}
\title{Checks if an argument is a string}
\usage{
assertString(x, na.ok = FALSE, ..., .var.name)

isString(x, na.ok = FALSE, ...)

asString(x, na.ok = FALSE, ..., .var.name)
}
\arguments{
  \item{x}{[\code{ANY}]\cr Object to check.}

  \item{.var.name}{[\code{logical(1)}]\cr Argument name to
  print in error message. If missing, the name of \code{x}
  will be retrieved via \code{\link[base]{substitute}}.}

  \item{na.ok}{[\code{logical(1)}]\cr Are missing values
  allowed? Default is \code{FALSE}.}

  \item{...}{[ANY]\cr Additional parameters used in a call
  of \code{\link{isCharacter}} or
  \code{\link{assertCharacter}}.}
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
A string a a single character value.
}

