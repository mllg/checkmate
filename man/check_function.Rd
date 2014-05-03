\name{check_function}
\alias{check_function}
\title{Check if an argument is a function}
\usage{
check_function(x, args, ordered = FALSE)
}
\arguments{
  \item{x}{[ANY]\cr Object to check.}

  \item{args}{[\code{character}]\cr Expected formal
  arguments.}

  \item{ordered}{[\code{logical(1)}]\cr Flag whether the
  arguments provided in \code{args} must be the first
  \code{length(args)} arguments of the function.  Default
  is \code{FALSE}.}
}
\value{
Returns \code{TRUE} on success and an error message
otherwise.  Intended to be used with \code{\link{test}},
\code{\link{assert}} or \code{\link{pass}}.
}
\description{
Check if an argument is a function
}
\examples{
test(mean, "function")
 test(check_function, "function", args = c("x", "ordered"))
 test(check_function, "function", args = "i.do.not.exist")
}
\seealso{
Other basetypes: \code{\link{check_character}};
\code{\link{check_complex}};
\code{\link{check_data.frame}};
\code{\link{check_environment}};
\code{\link{check_factor}}; \code{\link{check_integerish}};
\code{\link{check_integer}}; \code{\link{check_list}};
\code{\link{check_logical}}; \code{\link{check_matrix}};
\code{\link{check_numeric}}; \code{\link{check_vector}}
}

