\name{qcheckr}
\alias{qassertr}
\alias{qcheckr}
\title{Recursive arguments checks on lists and data frames.}
\usage{
qcheckr(x, rules)

qassertr(x, rules)
}
\arguments{
  \item{x}{[\code{list} or \code{data.frame}]\cr List or
  data frame to check for compliance with at least one of
  \code{rules}.  See details of \code{\link{qcheck}} for
  rule explanation.}

  \item{rules}{[\code{character}]\cr Set of rules. See
  \code{\link{qcheck}}}
}
\value{
[logical(1)]: \code{TRUE} on success, \code{FALSE} (or a
thrown exception) otherwise.
}
\description{
These functions are the tuned counterparts of
\code{\link{qcheck}} and \code{\link{qassert}} tailored for
recursive checks of list elements or data frame columns.
}
\examples{
qcheckr(as.list(1:10), "i+")
qcheck(iris, "n")
}
\seealso{
\code{\link{qcheck}}, \code{\link{qassert}}
}

