\name{check_list}
\alias{check_list}
\title{Check if an argument is a list}
\usage{
check_list(x, types = character(0L), ...)
}
\arguments{
  \item{x}{[ANY]\cr Object to check.}

  \item{...}{[ANY]\cr Additional parameters used in a call
  of \code{\link{check_vector}}.}

  \item{types}{[\code{character}]\cr Restrict elements to
  be atomic. Tests for \dQuote{logical}, \dQuote{integer},
  \dQuote{double}, \dQuote{numeric}, \dQuote{character},
  \dQuote{factor} or \dQuote{NULL}.  Defaults to
  \code{character(0)} (no type check).}
}
\value{
Returns \code{TRUE} on success and an error message
otherwise.  Intended to be used with \code{\link{test}},
\code{\link{assert}} or \code{\link{pass}}.
}
\description{
Check if an argument is a list
}
\examples{
test(list(), "list")
 test(as.list(iris), "list", types = c("numeric", "factor"))
}
\seealso{
Other basetypes: \code{\link{check_character}};
\code{\link{check_complex}};
\code{\link{check_data.frame}};
\code{\link{check_environment}};
\code{\link{check_factor}}; \code{\link{check_fun}};
\code{\link{check_integerish}};
\code{\link{check_integer}}; \code{\link{check_logical}};
\code{\link{check_matrix}}; \code{\link{check_numeric}};
\code{\link{check_vector}}
}

