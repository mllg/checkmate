\name{assertDirectory}
\alias{asDirectory}
\alias{assertDirectory}
\alias{isDirectory}
\title{Check or assert existance and access rights of directories}
\usage{
assertDirectory(x, access = "", .var.name)

isDirectory(x, access = "")

asDirectory(x, access = "", .var.name)
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
\item{\code{isDirectory}:}{Single logical value indicating
success.} \item{\code{assertDirectory}:}{\code{TRUE} on
success. An exception is thrown otherwise.}
\item{\code{asDirectory}:}{The (possibly converted) object
itself on success. An exception is thrown otherwise.} }
}
\description{
Check or assert existance and access rights of directories
}
\seealso{
\code{link{assertFile}}
}

