\name{check_inconstant}
\alias{check_inconstant}
\title{Check if elements of a vector are inequal / inconstant}
\usage{
check_inconstant(x, tol = .Machine$double.eps^0.5)
}
\arguments{
  \item{x}{[ANY]\cr Object to check.}

  \item{tol}{[\code{double(1)}]\cr Numerical tolerance used
  if \code{x} is of type \code{double} or \code{complex}.
  Default is \code{sqrt(.Machine$double.eps)}.}
}
\value{
Returns \code{TRUE} on success and an error message
otherwise.  Intended to be used with \code{\link{test}},
\code{\link{assert}} or \code{\link{pass}}.
}
\description{
Note that zero-length input is treated as constant.
}
\examples{
test(c(1, NA), "inconstant")
 test(c(0, 1-0.9-0.1), "inconstant")
 test(c(0, 1-0.9-0.1), "inconstant", tol = 0)
}
\seealso{
Other constant: \code{\link{check_constant}}
}

