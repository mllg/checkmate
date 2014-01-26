\name{any.missing}
\alias{any.missing}
\title{Checks if an object contains missing values.}
\usage{
\method{any}{missing}(x)
}
\arguments{
  \item{x}{[\code{ANY}]\cr Object to check.}
}
\value{
[\code{logical(1)}] Returns \code{TRUE} if at least one
element of \code{x} is missing (see details).
}
\description{
Supported are atomic types (see
\code{\link[base]{is.atomic}}), lists and data frames.
Missingness is defined ias \code{NA} or \code{NaN} for
atomic types and \code{NULL} for lists.
}

