\name{check_file}
\alias{check_file}
\title{Check existance and access rights of files}
\usage{
check_file(x, access = "")
}
\arguments{
  \item{x}{[\code{ANY}]\cr Object to check.}

  \item{access}{[\code{character}]\cr Single string with
  characters \sQuote{r}, \sQuote{w} and \sQuote{x} to force
  a check for read, write or execute access rights.}
}
\value{
Returns \code{TRUE} on success and an error message
otherwise.  Intended to be used with \code{\link{test}},
\code{\link{assert}} or \code{\link{pass}}.
}
\description{
Check existance and access rights of files
}
\seealso{
Other checker: \code{\link{check_character}};
\code{\link{check_class}}; \code{\link{check_constant}};
\code{\link{check_count}}; \code{\link{check_data.frame}};
\code{\link{check_directory}}; \code{\link{check_factor}};
\code{\link{check_flag}}; \code{\link{check_fun}};
\code{\link{check_inconstant}};
\code{\link{check_integerish}};
\code{\link{check_integer}}; \code{\link{check_list}};
\code{\link{check_logical}}; \code{\link{check_matrix}};
\code{\link{check_named}}; \code{\link{check_numeric}};
\code{\link{check_vector}}
}

