\name{checkVariable}
\alias{checkVariable}
\title{Checks if all elements are constant}
\usage{
checkVariable(x, tol = .Machine$double.eps^0.5)
}
\arguments{
  \item{x}{[\code{ANY}]\cr Object to check.}

  \item{tol}{[\code{double(1)}]\cr Numerical tolerance used
  if \code{x} is of type \code{double} or \code{complex}.
  Default is \code{sqrt(.Machine$double.eps)}.}
}
\value{
[\code{logical(1)}] Returns \code{TRUE} on success and
throws an exception on failure for assertion.
}
\description{
Checks if all elements are constant
}
\examples{
print(checkConstant(c(1, NA)))

x = c(0, 1 - 0.9 - 0.1)
print(identical(x[1], x[2]))
print(checkConstant(x))
}

