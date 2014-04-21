\name{check_matrix}
\alias{check_matrix}
\title{Check if an argument is a matrix}
\usage{
check_matrix(x, min.rows, min.cols, nrows, ncols, row.names = "any",
  col.names = "any")
}
\arguments{
  \item{x}{[ANY]\cr Object to check.}

  \item{min.rows}{[\code{integer(1)}]\cr Minimum number of
  rows.}

  \item{min.cols}{[\code{integer(1)}]\cr Minimum number of
  columns.}

  \item{nrows}{[\code{integer(1)}]\cr Exact number of
  rows.}

  \item{ncols}{[\code{integer(1)}]\cr Exact number of
  columns.}

  \item{row.names}{[\code{logical(1)}]\cr Check for row
  names. Default is \dQuote{any} (no check).  See
  \code{\link{check_named}} for possible values.}

  \item{col.names}{[\code{logical(1)}]\cr Check for column
  names. Default is \dQuote{any} (no check).  See
  \code{\link{check_named}} for possible values.}
}
\value{
Returns \code{TRUE} on success and an error message
otherwise.  Intended to be used with \code{\link{test}},
\code{\link{assert}} or \code{\link{pass}}.
}
\description{
Check if an argument is a matrix
}
\seealso{
Other checker: \code{\link{check_access}};
\code{\link{check_character}}; \code{\link{check_class}};
\code{\link{check_constant}}; \code{\link{check_count}};
\code{\link{check_data.frame}};
\code{\link{check_directory}};
\code{\link{check_elementOf}}; \code{\link{check_factor}};
\code{\link{check_file}}; \code{\link{check_flag}};
\code{\link{check_fun}}; \code{\link{check_inconstant}};
\code{\link{check_integerish}};
\code{\link{check_integer}}; \code{\link{check_list}};
\code{\link{check_logical}}; \code{\link{check_named}};
\code{\link{check_numeric}}; \code{\link{check_subset}};
\code{\link{check_vector}}
}

