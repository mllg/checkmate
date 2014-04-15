\name{assertInconstantVector}
\alias{asInconstantVector}
\alias{assertInconstantVector}
\alias{isInconstantVector}
\title{Checks if elements of a vector are variable}
\usage{
assertInconstantVector(x, tol = .Machine$double.eps^0.5, .var.name)

isInconstantVector(x, tol = .Machine$double.eps^0.5)

asInconstantVector(x, tol = .Machine$double.eps^0.5, .var.name)
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
\item{\code{isInconstantVector}:}{Single logical value
indicating success.}
\item{\code{assertInconstantVector}:}{\code{TRUE} on
success. An exception is thrown otherwise.}
\item{\code{asInconstantVector}:}{The (possibly converted)
object itself on success. An exception is thrown
otherwise.} }
}
\description{
Checks if elements of a vector are variable
}
\examples{
print(isInconstantVector(c(1, NA)))

x = c(0, 1 - 0.9 - 0.1)
print(identical(x[1], x[2]))
print(isInconstantVector(x))
}
\seealso{
\code{link{assertConstantVector}}
}

