\name{assertCount}
\alias{asCount}
\alias{assertCount}
\alias{isCount}
\title{Checks if an argument is a count}
\usage{
assertCount(x, na.ok = FALSE, .var.name)

isCount(x, na.ok = FALSE)

asCount(x, na.ok = FALSE, .var.name)
}
\arguments{
  \item{x}{[\code{ANY}]\cr Object to check.}

  \item{.var.name}{[\code{logical(1)}]\cr Argument name to
  print in error message. If missing, the name of \code{x}
  will be retrieved via \code{\link[base]{substitute}}.}

  \item{na.ok}{[\code{logical(1)}]\cr Are missing values
  allowed? Default is \code{FALSE}.}
}
\value{
Depending on the prefix: \describe{
\item{\code{isCount}:}{Single logical value indicating
success.} \item{\code{assertCount}:}{\code{TRUE} on
success. An exception is thrown otherwise.}
\item{\code{asCount}:}{The (possibly converted) object
itself on success. An exception is thrown otherwise.} }
}
\description{
A count a a single integerish numeric >= 0 which is not
missing.
}

