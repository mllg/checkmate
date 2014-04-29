\name{check_environment}
\alias{check_environment}
\title{Check if an argument is an environment}
\usage{
check_environment(x, contains = character(0L))
}
\arguments{
  \item{x}{[ANY]\cr Object to check.}

  \item{contains}{[\code{character}]\cr Vector of object
  names expected in the environment.  Defaults to
  \code{character(0)}.}
}
\value{
Returns \code{TRUE} on success and an error message
otherwise.  Intended to be used with \code{\link{test}},
\code{\link{assert}} or \code{\link{pass}}.
}
\description{
Check if an argument is an environment
}
\examples{
ee = as.environment(list(a = 1))
 test(ee, "environment")
 test(ee, "environment", contains = "a")
}
\seealso{
Other basetypes: \code{\link{check_character}};
\code{\link{check_complex}};
\code{\link{check_data.frame}}; \code{\link{check_factor}};
\code{\link{check_fun}}; \code{\link{check_integerish}};
\code{\link{check_integer}}; \code{\link{check_list}};
\code{\link{check_logical}}; \code{\link{check_matrix}};
\code{\link{check_numeric}}; \code{\link{check_vector}}
}

