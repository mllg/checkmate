\name{check_matrix}
\alias{check_matrix}
\title{Check if an argument is a matrix}
\usage{
check_matrix(x, any.missing = TRUE, min.rows, min.cols, nrows, ncols,
  row.names = "any", col.names = "any")
}
\arguments{
  \item{x}{[ANY]\cr Object to check.}

  \item{any.missing}{[\code{integer(1)}]\cr Are missing
  values allowed? Default is \code{TRUE}.}

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
\examples{
x = matrix(1:9, 3)
 colnames(x) = letters[1:3]
 test(x, "matrix", nrows = 3, min.cols = 1, col.names = "named")
}
\seealso{
Other basetypes: \code{\link{check_character}};
\code{\link{check_complex}};
\code{\link{check_data.frame}};
\code{\link{check_environment}};
\code{\link{check_factor}}; \code{\link{check_fun}};
\code{\link{check_integerish}};
\code{\link{check_integer}}; \code{\link{check_list}};
\code{\link{check_logical}}; \code{\link{check_numeric}};
\code{\link{check_vector}}
}

