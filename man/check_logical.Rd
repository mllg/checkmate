\name{check_logical}
\alias{check_logical}
\title{Check if an argument is a vector of type logical}
\usage{
check_logical(x, ...)
}
\arguments{
  \item{x}{[ANY]\cr Object to check.}

  \item{...}{[ANY]\cr Additional parameters used in a call
  of \code{\link{check_vector}}.}
}
\value{
Returns \code{TRUE} on success and an error message
otherwise.  Intended to be used with \code{\link{test}},
\code{\link{assert}} or \code{\link{pass}}.
}
\description{
Check if an argument is a vector of type logical
}
\note{
This function does not distinguish between \code{NA},
\code{NA_integer_}, \code{NA_real_}, \code{NA_complex_} and
\code{NA_character_}.
}
\examples{
test(TRUE, "logical")
 test(TRUE, "logical", min.len = 1)
}
\seealso{
Other basetypes: \code{\link{check_character}};
\code{\link{check_complex}};
\code{\link{check_data.frame}};
\code{\link{check_environment}};
\code{\link{check_factor}}; \code{\link{check_fun}};
\code{\link{check_integerish}};
\code{\link{check_integer}}; \code{\link{check_list}};
\code{\link{check_matrix}}; \code{\link{check_numeric}};
\code{\link{check_vector}}
}

