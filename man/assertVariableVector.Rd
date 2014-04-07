\name{assertVariableVector}
\alias{asVariableVector}
\alias{assertVariableVector}
\alias{isVariableVector}
\title{Checks if elements of a vector are variable}
\usage{
assertVariableVector(x, tol = .Machine$double.eps^0.5, .var.name)

isVariableVector(x, tol = .Machine$double.eps^0.5)

asVariableVector(x, tol = .Machine$double.eps^0.5, .var.name)
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
\item{\code{isVariableVector}:}{Single logical value
indicating success.}
\item{\code{assertVariableVector}:}{\code{TRUE} on success.
An exception is thrown otherwise.}
\item{\code{asVariableVector}:}{The (possibly converted)
object itself on success. An exception is thrown
otherwise.} }
}
\description{
Checks if elements of a vector are variable
}
\examples{
print(isVariableVector(c(1, NA)))

x = c(0, 1 - 0.9 - 0.1)
print(identical(x[1], x[2]))
print(isVariableVector(x))
}
\seealso{
\code{link{assertConstantVector}}
}

