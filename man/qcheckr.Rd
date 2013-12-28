\name{qassertr}
\alias{qassertr}
\alias{qcheckr}
\title{Check list elements or data frame columns against rules}
\usage{
qassertr(x, rules)

qcheckr(x, rules)
}
\arguments{
  \item{x}{[\code{list} or \code{data.frame}]\cr List
  elements or data frame columns to check against
  \code{rules}.  See \code{\link{qcheck}} for rule
  explanation.}

  \item{rules}{[\code{character}]\cr Set of rules. See
  \code{\link{qcheck}}}
}
\value{
[logical(1)]: \code{TRUE} if each element of \code{x}
complies at least one rule. Otherwise \code{FALSE} or an
exception is thrown.
}
\description{
Check list elements or data frame columns against rules
}
\examples{
qcheckr(as.list(1:10), "i+")
qcheck(iris, "n")
}
\seealso{
\code{\link{qcheck}}, \code{\link{qassert}}
}

