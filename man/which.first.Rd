\name{which.first}
\alias{which.first}
\alias{which.last}
\title{Find the index of first/last \code{TRUE} value in a logical vector.}
\usage{
which.first(x, use.names = TRUE)

which.last(x, use.names = TRUE)
}
\arguments{
  \item{x}{[\code{logical}]\cr Logical vector.}

  \item{use.names}{[\code{logical(1)}]\cr If \code{TRUE}
  and \code{x} is named, the result is also named.}
}
\value{
[\code{integer(1)} | \code{integer(0)}].  Returns the index
of the first/last \code{TRUE} value in \code{x} or an empty
integer vector if none is found.  If NAs are encountered
before a \code{TRUE} and not omitted, the result is
\code{NA_integer_}.
}
\description{
Find the index of first/last \code{TRUE} value in a logical
vector.
}

