\name{check_fun}
\alias{check_fun}
\title{Check if an argument to is a function}
\usage{
check_fun(x, args, ordered = FALSE)
}
\arguments{
  \item{x}{[ANY]\cr Object to check.}

  \item{args}{[\code{character}]\cr Expected formal
  arguments.}

  \item{ordered}{[\code{logical(1)}]\cr Flag whether the
  arguments provided in \code{args} must be the first
  arguments of the function and occur in the given order.
  Default is \code{FALSE}.}
}
\value{
Returns \code{TRUE} on success and an error message
otherwise.  Intended to be used with \code{\link{test}},
\code{\link{assert}} or \code{\link{pass}}.
}
\description{
Check if an argument to is a function
}
\seealso{
Other checker: \code{\link{check_character}};
\code{\link{check_class}}; \code{\link{check_constant}};
\code{\link{check_count}}; \code{\link{check_data.frame}};
\code{\link{check_directory}}; \code{\link{check_factor}};
\code{\link{check_file}}; \code{\link{check_flag}};
\code{\link{check_inconstant}};
\code{\link{check_integerish}};
\code{\link{check_integer}}; \code{\link{check_list}};
\code{\link{check_logical}}; \code{\link{check_matrix}};
\code{\link{check_named}}; \code{\link{check_numeric}};
\code{\link{check_vector}}
}

