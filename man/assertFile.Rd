\name{assertFile}
\alias{assertDirectory}
\alias{assertFile}
\alias{checkDirectory}
\alias{checkFile}
\title{Check or assert existance and access rights of files and directories}
\usage{
assertFile(fn, access = "", .var.name)

checkFile(fn, access = "")

checkDirectory(fn, access = "")

assertDirectory(fn, access = "", .var.name)
}
\arguments{
  \item{fn}{[\code{character}\code{function}]\cr Vector of
  file or directory names}

  \item{access}{[\code{character}]\cr Single string with
  characters \sQuote{r}, \sQuote{w} and \sQuote{x} to force
  a check for read, write or execute access rights.}

  \item{.var.name}{[\code{logical(1)}]\cr Argument name to
  print in error message. If missing, the name of \code{x}
  will be retrieved via \code{\link[base]{substitute}}.}
}
\value{
[\code{logical(1)}] Returns \code{TRUE} on success.  Throws
an exception on failure for assertion.
}
\description{
Check or assert existance and access rights of files and
directories
}

