\name{check_class}
\alias{check_class}
\title{Check argument inheritance}
\usage{
check_class(x, classes, ordered = FALSE)
}
\arguments{
  \item{x}{[ANY]\cr Object to check.}

  \item{classes}{[\code{character}]\cr Class names to check
  for inheritance.}

  \item{ordered}{[\code{logical(1)}]\cr Expect \code{x} to
  be specialized in provided order.  Default is
  \code{FALSE}.}
}
\value{
Returns \code{TRUE} on success and an error message
otherwise.  Intended to be used with \code{\link{test}},
\code{\link{assert}} or \code{\link{pass}}.
}
\description{
Check argument inheritance
}
\seealso{
Other checker: \code{\link{check_access}};
\code{\link{check_character}};
\code{\link{check_constant}}; \code{\link{check_count}};
\code{\link{check_data.frame}};
\code{\link{check_directory}};
\code{\link{check_elementOf}}; \code{\link{check_factor}};
\code{\link{check_file}}; \code{\link{check_flag}};
\code{\link{check_fun}}; \code{\link{check_inconstant}};
\code{\link{check_integerish}};
\code{\link{check_integer}}; \code{\link{check_list}};
\code{\link{check_logical}}; \code{\link{check_matrix}};
\code{\link{check_named}}; \code{\link{check_numeric}};
\code{\link{check_subset}}; \code{\link{check_vector}}
}

