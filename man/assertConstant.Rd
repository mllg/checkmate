\name{assertConstant}
\alias{assertConstant}
\alias{assertVariable}
\alias{checkConstant}
\alias{checkVariable}
\title{Checks if all elements of a vector are constant}
\usage{
assertConstant(x, tol = .Machine$double.eps^0.5, .var.name)

checkConstant(x, tol = .Machine$double.eps^0.5)

checkVariable(x, tol = .Machine$double.eps^0.5)

assertVariable(x, tol = .Machine$double.eps^0.5, .var.name)
}
\arguments{
  \item{x}{[\code{ANY}]\cr Object to check.}

  \item{tol}{[\code{double(1)}]\cr Numerical tolerance used
  if \code{x} is of type \code{double} or \code{complex}.
  Default is \code{sqrt(.Machine$double.eps)}.}

  \item{.var.name}{[\code{logical(1)}]\cr Argument name to
  print in error message. If missing, the name of \code{x}
  will be retrieved via \code{\link[base]{substitute}}.}
}
\value{
[\code{logical(1)}] Returns \code{TRUE} on success.  Throws
an exception on failure for assertion.
}
\description{
Checks if all elements of a vector are constant
}
\examples{
print(checkVariable(c(1, NA)))

x = c(0, 1 - 0.9 - 0.1)
print(identical(x[1], x[2]))
print(checkVariable(x))
}

