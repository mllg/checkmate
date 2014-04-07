\name{assertClasses}
\alias{assertClasses}
\alias{isClasses}
\title{Checks argument inheritance}
\usage{
assertClasses(x, classes, .var.name)

isClasses(x, classes)
}
\arguments{
  \item{x}{[\code{ANY}]\cr Object to check.}

  \item{classes}{[\code{character}]\cr Class names to check
  for inheritance.}

  \item{.var.name}{[\code{logical(1)}]\cr Argument name to
  print in error message. If missing, the name of \code{x}
  will be retrieved via \code{\link[base]{substitute}}.}
}
\value{
[\code{logical(1)}] Returns \code{TRUE} if \code{x}
inherits from all \code{classes}.  Throws an exception on
failure for assertion.
}
\description{
Checks argument inheritance
}

