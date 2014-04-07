\name{assertClasses}
\alias{assertClasses}
\alias{isClasses}
\title{Checks argument inheritance}
\usage{
assertClasses(x, classes, ordered = FALSE, .var.name)

isClasses(x, classes, ordered = FALSE)
}
\arguments{
  \item{x}{[\code{ANY}]\cr Object to check.}

  \item{.var.name}{[\code{logical(1)}]\cr Argument name to
  print in error message. If missing, the name of \code{x}
  will be retrieved via \code{\link[base]{substitute}}.}

  \item{classes}{[\code{character}]\cr Class names to check
  for inheritance.}

  \item{ordered}{[\code{logical(1)}]\cr Expect \code{x} to
  be specialized in provided order.  Default is
  \code{FALSE}.}
}
\value{
Depending on the prefix: \describe{
\item{\code{isClasses}:}{Single logical value indicating
success.} \item{\code{assertClasses}:}{\code{TRUE} on
success. An exception is thrown otherwise.}
\item{\code{asClasses}:}{The (possibly converted) object
itself on success. An exception is thrown otherwise.} }
}
\description{
Checks argument inheritance
}

