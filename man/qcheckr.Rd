\name{qcheckr}
\alias{qassertr}
\alias{qcheckr}
\title{Check lists against rules}
\usage{
qcheckr(x, rules)

qassertr(x, rules)
}
\arguments{
  \item{x}{[\code{list} or \code{data.frame}]\cr List
  elements or data frame columns to check for compliance
  with \code{rules}.  See details of \code{\link{qcheck}}
  for rule explanation.}

  \item{rules}{[\code{character}]\cr Set of rules. See
  \code{\link{qcheck}}}
}
\value{
[logical(1)]: \code{TRUE} on success, \code{FALSE} (or a
thrown exception) otherwise.
}
\description{
Check lists against rules
}
\examples{
qcheckr(as.list(1:10), "i+")
qcheck(iris, "n")
}
\seealso{
\code{\link{qcheck}}, \code{\link{qassert}}
}

