\name{check_factor}
\alias{check_factor}
\title{Check if an argument is a factor}
\usage{
check_factor(x, levels, ordered = NA, empty.levels.ok = TRUE, ...)
}
\arguments{
  \item{x}{[\code{ANY}]\cr Object to check.}

  \item{levels}{[\code{character}]\cr Vector of allowed
  factor levels.}

  \item{ordered}{[\code{logical(1)}]\cr Check for an
  ordered factor? If \code{FALSE}, checks explicitly for an
  unordered factor.  Default is \code{NA} which disables
  this check.}

  \item{empty.levels.ok}{[\code{logical(1)}]\cr Are empty
  levels allowed?  Default is \code{TRUE}.}

  \item{...}{[ANY]\cr Additional parameters used in a call
  of \code{\link{check_vector}} or
  \code{\link{check_vector}}.}
}
\value{
Returns \code{TRUE} on success and an error message
otherwise.  Intended to be used with \code{\link{test}},
\code{\link{assert}} or \code{\link{pass}}.
}
\description{
Check if an argument is a factor
}
\seealso{
Other checker: \code{\link{check_character}};
\code{\link{check_class}}; \code{\link{check_constant}};
\code{\link{check_count}}; \code{\link{check_data.frame}};
\code{\link{check_directory}}; \code{\link{check_file}};
\code{\link{check_flag}}; \code{\link{check_fun}};
\code{\link{check_inconstant}};
\code{\link{check_integerish}};
\code{\link{check_integer}}; \code{\link{check_list}};
\code{\link{check_logical}}; \code{\link{check_matrix}};
\code{\link{check_named}}; \code{\link{check_numeric}};
\code{\link{check_vector}}
}

