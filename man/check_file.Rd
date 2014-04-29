\name{check_file}
\alias{check_file}
\title{Check existance and access rights of files}
\usage{
check_file(x, access = "")
}
\arguments{
  \item{x}{[ANY]\cr Object to check.}

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
\examples{
# Check if R's COPYING file is readable
 test(file.path(R.home(), "COPYING"), "file", access = "r")

 # Check if R's COPYING file is writeable
 test(file.path(R.home(), "COPYING"), "file", access = "w")
}
\seealso{
Other filesystem: \code{\link{check_access}};
\code{\link{check_directory}}
}

