\name{check_complex}
\alias{check_complex}
\title{Check if an argument is a vector of type complex}
\usage{
check_complex(x, ...)
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
Check if an argument is a vector of type complex
}
\note{
This function does not distinguish between \code{NA},
\code{NA_integer_}, \code{NA_real_}, \code{NA_complex_} and
\code{NA_character_}.
}
\examples{
test(1L, "complex")
 test(1., "complex")
}
\seealso{
Other basetypes: \code{\link{check_character}};
\code{\link{check_data.frame}};
\code{\link{check_environment}};
\code{\link{check_factor}}; \code{\link{check_function}};
\code{\link{check_integerish}};
\code{\link{check_integer}}; \code{\link{check_list}};
\code{\link{check_logical}}; \code{\link{check_matrix}};
\code{\link{check_numeric}}; \code{\link{check_vector}}
}

