\name{check_named}
\alias{check_named}
\title{Check if an argument is named}
\usage{
check_named(x, type = "named")
}
\arguments{
  \item{x}{[ANY]\cr Object to check.}

  \item{type}{[character(1)]\cr Select the check(s) to
  perform.  \dQuote{unnamed} checks \code{x} to be unnamed.
  \dQuote{named} (default) checks \code{x} to be named,
  this includes names to be not \code{NA} or emtpy
  (\code{""}).  \dQuote{unique} additionally tests for
  non-duplicated names and \code{strict} tests the names to
  comply to R's variable naming rules on top of
  \dQuote{unique}.  Note that for zero-length \code{x}
  every name check evalutes to \code{TRUE}.}
}
\value{
Returns \code{TRUE} on success and an error message
otherwise.  Intended to be used with \code{\link{test}},
\code{\link{assert}} or \code{\link{pass}}.
}
\description{
Check if an argument is named
}
\examples{
x = 1:3
 test(x, "named", "unnamed")
 names(x) = letters[1:3]
 test(x, "named", "unique")
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
\code{\link{check_logical}}; \code{\link{check_matrix}};
\code{\link{check_numeric}}; \code{\link{check_subset}};
\code{\link{check_vector}}
}

