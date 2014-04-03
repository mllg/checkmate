\name{qassertr}
\alias{qassertr}
\alias{qcheckr}
\title{Recursive arguments checks on lists and data frames.}
\usage{
qassertr(x, rules, .var.name)

qcheckr(x, rules)
}
\arguments{
  \item{x}{[\code{list} or \code{data.frame}]\cr List or
  data frame to check for compliance with at least one of
  \code{rules}.  See details of \code{\link{qcheck}} for
  rule explanation.}

  \item{rules}{[\code{character}]\cr Set of rules. See
  \code{\link{qcheck}}}

  \item{.var.name}{[\code{logical(1)}]\cr Argument name to
  print in error message. If missing, the name of \code{x}
  will be retrieved via \code{\link[base]{substitute}}.}
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

