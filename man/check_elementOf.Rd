\name{check_elementOf}
\alias{check_elementOf}
\title{Check if an object is element of a given set}
\usage{
check_elementOf(x, choices)
}
\arguments{
  \item{x}{[ANY]\cr Object to check.}

  \item{choices}{[\code{atomic}]\cr Set of possible
  values.}
}
\value{
Returns \code{TRUE} on success and an error message
otherwise.  Intended to be used with \code{\link{test}},
\code{\link{assert}} or \code{\link{pass}}.
}
\description{
Check if an object is element of a given set
}
\examples{
test("x", "elementOf", letters)
}
\seealso{
Other set: \code{\link{check_subset}}
}

