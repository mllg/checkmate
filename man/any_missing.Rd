\name{any_missing}
\alias{any_missing}
\title{Check if an object contains missing values.}
\usage{
any_missing(x)
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
Missingness is defined as values being \code{NA} or
\code{NaN} for atomic types and \code{NULL} for lists.
}

