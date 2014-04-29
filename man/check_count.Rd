\name{check_count}
\alias{check_count}
\title{Check if an argument is a count}
\usage{
check_count(x, na.ok = FALSE)
}
\arguments{
  \item{x}{[ANY]\cr Object to check.}

  \item{na.ok}{[\code{logical(1)}]\cr Are missing values
  allowed? Default is \code{FALSE}.}
}
\value{
Returns \code{TRUE} on success and an error message
otherwise.  Intended to be used with \code{\link{test}},
\code{\link{assert}} or \code{\link{pass}}.
}
\description{
Check if an argument is a count
}
\note{
This function does not distinguish between \code{NA},
\code{NA_integer_}, \code{NA_real_}, \code{NA_complex_} and
\code{NA_character_}.
}
\examples{
test(1, "count")
 test(-1, "count")
 test(Inf, "count")
}

