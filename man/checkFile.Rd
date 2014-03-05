\name{checkFile}
\alias{assertDirectory}
\alias{assertFile}
\alias{checkDirectory}
\alias{checkFile}
\title{Check or assert  existance and access rights of files and directories}
\usage{
checkFile(fn, access)

assertFile(fn, access)

checkDirectory(fn, access)

assertDirectory(fn, access)
}
\arguments{
  \item{fn}{[\code{character}\code{function}]\cr Vector of
  file or directory names names}

  \item{access}{[\code{character}]\cr Single string with
  characters \sQuote{r}, \sQuote{w} and \sQuote{x} to force
  a check for read, write or execute access rights.}
}
\value{
[\code{logical(1)}] Returns \code{TRUE} on success and
throws an exception on failure for assertion.
}
\description{
Check or assert existance and access rights of files and
directories
}

