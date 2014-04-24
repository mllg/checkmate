\name{check_numeric}
\alias{check_numeric}
\title{Check if an argument is a numeric vector}
\usage{
check_numeric(x, lower, upper, ...)
}
\arguments{
  \item{x}{[ANY]\cr Object to check.}

  \item{lower}{[\code{numeric(1)}]\cr Lower value all
  elements of \code{x} must be greater than.}

  \item{upper}{[\code{numeric(1)}]\cr Upper value all
  elements of \code{x} must be lower than.}

  \item{...}{[ANY]\cr Additional parameters used in a call
  of \code{\link{check_vector}}.}
}
\value{
Returns \code{TRUE} on success and an error message
otherwise.  Intended to be used with \code{\link{test}},
\code{\link{assert}} or \code{\link{pass}}.
}
\description{
Check if an argument is a numeric vector
}
\examples{
test(1L, "numeric")
 test(1., "numeric")
}
\seealso{
Other checker: \code{\link{check_access}};
\code{\link{check_character}}; \code{\link{check_class}};
\code{\link{check_complex}}; \code{\link{check_constant}};
\code{\link{check_count}}; \code{\link{check_data.frame}};
\code{\link{check_directory}};
\code{\link{check_elementOf}};
\code{\link{check_environment}};
\code{\link{check_factor}}; \code{\link{check_file}};
\code{\link{check_flag}}; \code{\link{check_fun}};
\code{\link{check_inconstant}};
\code{\link{check_integerish}};
\code{\link{check_integer}}; \code{\link{check_list}};
\code{\link{check_logical}}; \code{\link{check_matrix}};
\code{\link{check_named}}; \code{\link{check_subset}};
\code{\link{check_vector}}
}

