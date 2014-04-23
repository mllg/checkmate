\name{check_vector}
\alias{check_vector}
\title{Check vector properties}
\usage{
check_vector(x, na.ok = TRUE, len, min.len, max.len, names = "any")
}
\arguments{
  \item{x}{[ANY]\cr Object to check.}

  \item{na.ok}{[\code{logical(1)}]\cr Are missing values
  allowed? Default is \code{TRUE}.}

  \item{len}{[\code{integer(1)}]\cr Exact expected length
  of \code{x}.}

  \item{min.len}{[\code{integer(1)}]\cr Minimal length of
  \code{x}.}

  \item{max.len}{[\code{integer(1)}]\cr Maximal length of
  \code{x}.}

  \item{names}{[\code{character(1)}]\cr Check for names
  attribute.  See also \code{\link{check_named}} for
  possible values.  Default is \dQuote{none} which performs
  no check at all.}
}
\value{
Returns \code{TRUE} on success and an error message
otherwise.  Intended to be used with \code{\link{test}},
\code{\link{assert}} or \code{\link{pass}}.
}
\description{
Check vector properties
}
\examples{
test(letters, "vector", min.len = 1L, na.ok = FALSE)
}
\seealso{
Other checker: \code{\link{check_access}};
\code{\link{check_character}}; \code{\link{check_class}};
\code{\link{check_constant}}; \code{\link{check_count}};
\code{\link{check_data.frame}};
\code{\link{check_directory}};
\code{\link{check_elementOf}};
\code{\link{check_environment}};
\code{\link{check_factor}}; \code{\link{check_file}};
\code{\link{check_flag}}; \code{\link{check_fun}};
\code{\link{check_inconstant}};
\code{\link{check_integerish}};
\code{\link{check_integer}}; \code{\link{check_list}};
\code{\link{check_logical}}; \code{\link{check_matrix}};
\code{\link{check_named}}; \code{\link{check_numeric}};
\code{\link{check_subset}}
}

