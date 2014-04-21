\name{check_string}
\alias{check_string}
\title{Check if an argument is a string}
\usage{
check_string(x, na.ok = FALSE, ...)
}
\arguments{
  \item{x}{[ANY]\cr Object to check.}

  \item{na.ok}{[\code{logical(1)}]\cr Are missing values
  allowed? Default is \code{FALSE}.}

  \item{...}{[ANY]\cr Additional parameters used in a call
  of \code{\link{check_character}}.}
}
\value{
Returns \code{TRUE} on success and an error message
otherwise.  Intended to be used with \code{\link{test}},
\code{\link{assert}} or \code{\link{pass}}.
}
\description{
A string a character vector of length 1.
}
\examples{
test("a", "string")
 test(letters, "string")
}

