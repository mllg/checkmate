\name{check_character}
\alias{check_character}
\title{Check if an argument is a vector of type character}
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
Check if an argument is a vector of type character
}
\note{
This function does not distinguish between \code{NA},
\code{NA_integer_}, \code{NA_real_}, \code{NA_complex_} and
\code{NA_character_}.
}
\examples{
test(letters, "character", min.len = 1, any.missing = FALSE)
 test(letters, "character", min.chars = 2)
 test("example", "character", pattern = "ple")
}
\seealso{
Other basetypes: \code{\link{check_complex}};
\code{\link{check_data.frame}};
\code{\link{check_environment}};
\code{\link{check_factor}}; \code{\link{check_fun}};
\code{\link{check_integerish}};
\code{\link{check_integer}}; \code{\link{check_list}};
\code{\link{check_logical}}; \code{\link{check_matrix}};
\code{\link{check_numeric}}; \code{\link{check_vector}}
}

