\name{check_flag}
\alias{check_flag}
\title{Check if an argument is a flag}
\usage{
check_flag(x, na.ok = FALSE)
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
A flag a a single logical value.
}
\note{
This function does not distinguish between \code{NA},
\code{NA_integer_}, \code{NA_real_}, \code{NA_complex_} and
\code{NA_character_}.
}
\examples{
test(TRUE, "flag")
 test(1, "flag")
}

