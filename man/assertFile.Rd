\name{assertDirectory}
\alias{asDirectory}
\alias{asFile}
\alias{assertDirectory}
\alias{assertFile}
\alias{isDirectory}
\alias{isFile}
\title{Check or assert existance and access rights of files and directories}
\usage{
assertDirectory(x, access = "", .var.name)

isDirectory(x, access = "")

asDirectory(x, access = "", .var.name)

assertFile(x, access = "", .var.name)

isFile(x, access = "")

asFile(x, access = "", .var.name)
}
\arguments{
  \item{x}{[\code{character}\code{function}]\cr Vector of
  file or directory names.}

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

