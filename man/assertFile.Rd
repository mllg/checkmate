\name{assertFile}
\alias{asFile}
\alias{assertFile}
\alias{isFile}
\title{Check or assert existance and access rights of files and directories}
\usage{
assertFile(x, access = "", .var.name)

isFile(x, access = "")

asFile(x, access = "", .var.name)
}
\arguments{
  \item{x}{[\code{ANY}]\cr Object to check.}

  \item{.var.name}{[\code{logical(1)}]\cr Argument name to
  print in error message. If missing, the name of \code{x}
  will be retrieved via \code{\link[base]{substitute}}.}

  \item{access}{[\code{character}]\cr Single string with
  characters \sQuote{r}, \sQuote{w} and \sQuote{x} to force
  a check for read, write or execute access rights.}
}
\value{
Depending on the prefix: \describe{
\item{\code{isFile}:}{Single logical value indicating
success.} \item{\code{assertFile}:}{\code{TRUE} on success.
An exception is thrown otherwise.}
\item{\code{asFile}:}{The (possibly converted) object
itself on success. An exception is thrown otherwise.} }
}
\description{
Check or assert existance and access rights of files and
directories
}
\seealso{
\code{link{assertDirectory}}
}

