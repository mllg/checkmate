\name{assertFlag}
\alias{asFlag}
\alias{assertFlag}
\alias{isFlag}
\title{Checks if an argument is a flag}
\usage{
assertFlag(x, na.ok = FALSE, .var.name)

isFlag(x, na.ok = FALSE)

asFlag(x, na.ok = FALSE, .var.name)
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
\item{\code{isFlag}:}{Single logical value indicating
success.} \item{\code{assertFlag}:}{\code{TRUE} on success.
An exception is thrown otherwise.}
\item{\code{asFlag}:}{The (possibly converted) object
itself on success. An exception is thrown otherwise.} }
}
\description{
A flag a a single logical value which is not missing.
}

