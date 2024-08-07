% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/checkFlag.R
\name{checkFlag}
\alias{checkFlag}
\alias{check_flag}
\alias{assertFlag}
\alias{assert_flag}
\alias{testFlag}
\alias{test_flag}
\alias{expect_flag}
\title{Check if an argument is a flag}
\usage{
checkFlag(x, na.ok = FALSE, null.ok = FALSE)

check_flag(x, na.ok = FALSE, null.ok = FALSE)

assertFlag(x, na.ok = FALSE, null.ok = FALSE, .var.name = vname(x), add = NULL)

assert_flag(
  x,
  na.ok = FALSE,
  null.ok = FALSE,
  .var.name = vname(x),
  add = NULL
)

testFlag(x, na.ok = FALSE, null.ok = FALSE)

test_flag(x, na.ok = FALSE, null.ok = FALSE)

expect_flag(x, na.ok = FALSE, null.ok = FALSE, info = NULL, label = vname(x))
}
\arguments{
\item{x}{[any]\cr
Object to check.}

\item{na.ok}{[\code{logical(1)}]\cr
Are missing values allowed? Default is \code{FALSE}.}

\item{null.ok}{[\code{logical(1)}]\cr
If set to \code{TRUE}, \code{x} may also be \code{NULL}.
In this case only a type check of \code{x} is performed, all additional checks are disabled.}

\item{.var.name}{[\code{character(1)}]\cr
Name of the checked object to print in assertions. Defaults to
the heuristic implemented in \code{\link{vname}}.}

\item{add}{[\code{AssertCollection}]\cr
Collection to store assertion messages. See \code{\link{AssertCollection}}.}

\item{info}{[\code{character(1)}]\cr
Extra information to be included in the message for the testthat reporter.
See \code{\link[testthat]{expect_that}}.}

\item{label}{[\code{character(1)}]\cr
Name of the checked object to print in messages. Defaults to
the heuristic implemented in \code{\link{vname}}.}
}
\value{
Depending on the function prefix:
 If the check is successful, the functions 
 \code{assertFlag}/\code{assert_flag} return 
 \code{x} invisibly, whereas
 \code{checkFlag}/\code{check_flag} and 
 \code{testFlag}/\code{test_flag} return 
 \code{TRUE}.
 If the check is not successful, 
 \code{assertFlag}/\code{assert_flag}
 throws an error message, 
 \code{testFlag}/\code{test_flag}
 returns \code{FALSE},
 and \code{checkFlag}/\code{check_flag} 
 return a string with the error message.
 The function \code{expect_flag} always returns an
 \code{\link[testthat]{expectation}}.
}
\description{
A flag is defined as single logical value.
}
\details{
This function does not distinguish between
\code{NA}, \code{NA_integer_}, \code{NA_real_}, \code{NA_complex_}
\code{NA_character_} and \code{NaN}.
}
\examples{
testFlag(TRUE)
testFlag(1)
}
\seealso{
Other scalars: 
\code{\link{checkCount}()},
\code{\link{checkInt}()},
\code{\link{checkNumber}()},
\code{\link{checkScalar}()},
\code{\link{checkScalarNA}()},
\code{\link{checkString}()}
}
\concept{scalars}
