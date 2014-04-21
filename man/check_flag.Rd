\name{check_flag}
\alias{check_flag}
\title{Check if an argument is a flag}
\usage{
check_flag(x, na.ok = FALSE)
}
\arguments{
  \item{x}{[ANY]\cr Object to check.}

  \item{na.ok}{[\code{logical(1)}]\cr Are missing values
  allowed? Default is \code{FALSE}.}
}
\value{
Returns \code{TRUE} on success and an error message
otherwise.  Intended to be used with \code{\link{test}},
\code{\link{assert}} or \code{\link{pass}}.
}
\description{
A flag a a single logical value which is not missing.
}
\seealso{
Other checker: \code{\link{check_character}};
\code{\link{check_class}}; \code{\link{check_constant}};
\code{\link{check_count}}; \code{\link{check_data.frame}};
\code{\link{check_directory}}; \code{\link{check_factor}};
\code{\link{check_file}}; \code{\link{check_fun}};
\code{\link{check_inconstant}};
\code{\link{check_integerish}};
\code{\link{check_integer}}; \code{\link{check_list}};
\code{\link{check_logical}}; \code{\link{check_matrix}};
\code{\link{check_named}}; \code{\link{check_numeric}};
\code{\link{check_vector}}
}

