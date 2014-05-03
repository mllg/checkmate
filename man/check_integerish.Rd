\name{check_integerish}
\alias{check_integerish}
\title{Check if an object is an integerish vector}
\usage{
check_integerish(x, lower, upper, tol = .Machine$double.eps^0.5, ...)
}
\arguments{
  \item{x}{[ANY]\cr Object to check.}

  \item{tol}{[\code{double(1)}]\cr Numerical tolerance used
  to check if a double or complex can be converted.
  Default is \code{sqrt(.Machine$double.eps)}.}

  \item{...}{[ANY]\cr Additional parameters used in a call
  of \code{\link{check_vector}}.}

  \item{lower}{[\code{numeric(1)}]\cr Lower value all
  elements of \code{x} must be greater than or equal.}

  \item{upper}{[\code{numeric(1)}]\cr Upper value all
  elements of \code{x} must be lower than or equal.}
}
\value{
Returns \code{TRUE} on success and an error message
otherwise.  Intended to be used with \code{\link{test}},
\code{\link{assert}} or \code{\link{pass}}.
}
\description{
Check if an object is an integerish vector
}
\note{
This function does not distinguish between \code{NA},
\code{NA_integer_}, \code{NA_real_}, \code{NA_complex_} and
\code{NA_character_}.
}
\examples{
test(1L, "integerish")
 test(1., "integerish")
 test(1:2, "integerish", lower = 1L, upper = 2L, any.missing = FALSE)
}
\seealso{
Other basetypes: \code{\link{check_character}};
\code{\link{check_complex}};
\code{\link{check_data.frame}};
\code{\link{check_environment}};
\code{\link{check_factor}}; \code{\link{check_function}};
\code{\link{check_integer}}; \code{\link{check_list}};
\code{\link{check_logical}}; \code{\link{check_matrix}};
\code{\link{check_numeric}}; \code{\link{check_vector}}
}

