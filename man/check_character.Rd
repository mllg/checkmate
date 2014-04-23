\name{check_character}
\alias{check_character}
\title{Check if an argument is a character vector}
\usage{
check_character(x, pattern, ignore.case = FALSE, perl = FALSE,
  fixed = FALSE, min.chars = 0L, ...)
}
\arguments{
  \item{x}{[ANY]\cr Object to check.}

  \item{pattern}{[\code{character(1L)}]\cr Regular
  expression as used to use in \code{\link[base]{grepl}}.
  All elements of \code{x} must comply to this pattern.}

  \item{ignore.case}{[\code{logical(1)}]\cr See
  \code{\link[base]{grepl}}. Default is \code{FALSE}.}

  \item{perl}{[\code{logical(1)}]\cr See
  \code{\link[base]{grepl}}. Default is \code{FALSE}.}

  \item{fixed}{[\code{logical(1)}]\cr See
  \code{\link[base]{grepl}}. Default is \code{FALSE}.}

  \item{min.chars}{[\code{integer(1)}]\cr Minimum number of
  characters in each element of \code{x}.}

  \item{...}{[ANY]\cr Additional parameters used in a call
  of \code{\link{check_vector}}.}
}
\value{
Returns \code{TRUE} on success and an error message
otherwise.  Intended to be used with \code{\link{test}},
\code{\link{assert}} or \code{\link{pass}}.
}
\description{
Check if an argument is a character vector
}
\examples{
test(letters, "character", min.len = 1, na.ok = FALSE)
 test(letters, "character", min.chars = 2)
 test("example", "character", pattern = "ple")
}
\seealso{
Other checker: \code{\link{check_access}};
\code{\link{check_class}}; \code{\link{check_constant}};
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
\code{\link{check_named}}; \code{\link{check_numeric}};
\code{\link{check_subset}}; \code{\link{check_vector}}
}

