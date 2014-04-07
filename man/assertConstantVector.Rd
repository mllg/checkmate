\name{assertConstantVector}
\alias{asConstant}
\alias{assertConstantVector}
\alias{isConstantVector}
\title{Checks if all elements of a vector are equal}
\usage{
assertConstantVector(x, tol = .Machine$double.eps^0.5, .var.name)

isConstantVector(x, tol = .Machine$double.eps^0.5)

asConstant(x, tol = .Machine$double.eps^0.5, .var.name)
}
\arguments{
  \item{x}{[\code{ANY}]\cr Object to check.}

  \item{.var.name}{[\code{logical(1)}]\cr Argument name to
  print in error message. If missing, the name of \code{x}
  will be retrieved via \code{\link[base]{substitute}}.}

  \item{tol}{[\code{double(1)}]\cr Numerical tolerance used
  if \code{x} is of type \code{double} or \code{complex}.
  Default is \code{sqrt(.Machine$double.eps)}.}
}
\value{
Depending on the prefix: \describe{
\item{\code{isConstantVector}:}{Single logical value
indicating success.}
\item{\code{assertConstantVector}:}{\code{TRUE} on success.
An exception is thrown otherwise.}
\item{\code{asConstantVector}:}{The (possibly converted)
object itself on success. An exception is thrown
otherwise.} }
}
\description{
Checks if all elements of a vector are equal
}
\seealso{
\code{link{assertVariableVector}}
}

