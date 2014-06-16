% Generated by roxygen2 (4.0.1): do not edit by hand
\name{checkPathForOutput}
\alias{assertPathForOutput}
\alias{checkPathForOutput}
\alias{testPathForOutput}
\title{Check file path for later output}
\usage{
checkPathForOutput(x)

assertPathForOutput(x, .var.name)

testPathForOutput(x)
}
\arguments{
\item{x}{[ANY]\cr
Object to check.}

\item{.var.name}{[character(1)]\cr
Name for \code{x}. Defaults to a heuristic to determine
the name using \code{\link[base]{deparse}} and \code{\link[base]{substitute}}.}
}
\value{
Depending on the function prefix:
 If the check is successful, all functions return \code{TRUE}.
 If the check is not successful, \code{assertPathForOutput} throws an error message,
 \code{testPathForOutput} returns \code{FALSE} and \code{checkPathForOutput} returns
 a string with the error message.
}
\description{
Check whether a file path can later be safely used to create a file and write to it.

This is checked:
\itemize{
\item{Does \code{dirname(x)} exist?}
\item{Does no file under path \code{x)} exist?}
\item{Is \code{dirname(x)} writeable?}
}

A string without slashes is interpreted as a file in the current working directory.
}
\seealso{
Other filesystem: \code{\link{assertAccess}},
  \code{\link{checkAccess}}, \code{\link{testAccess}};
  \code{\link{assertDirectory}},
  \code{\link{checkDirectory}},
  \code{\link{testDirectory}}; \code{\link{assertFile}},
  \code{\link{checkFile}}, \code{\link{testFile}}
}
