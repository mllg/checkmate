% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/checkSetEqual.R
\name{checkSetEqual}
\alias{checkSetEqual}
\alias{check_set_equal}
\alias{assertSetEqual}
\alias{assert_set_equal}
\alias{testSetEqual}
\alias{test_set_equal}
\alias{expect_set_equal}
\title{Check if an argument is equal to a given set}
\usage{
checkSetEqual(x, y, ordered = FALSE, fmatch = FALSE)

check_set_equal(x, y, ordered = FALSE, fmatch = FALSE)

assertSetEqual(
  x,
  y,
  ordered = FALSE,
  fmatch = FALSE,
  .var.name = vname(x),
  add = NULL
)

assert_set_equal(
  x,
  y,
  ordered = FALSE,
  fmatch = FALSE,
  .var.name = vname(x),
  add = NULL
)

testSetEqual(x, y, ordered = FALSE, fmatch = FALSE)

test_set_equal(x, y, ordered = FALSE, fmatch = FALSE)

expect_set_equal(
  x,
  y,
  ordered = FALSE,
  fmatch = FALSE,
  info = NULL,
  label = vname(x)
)
}
\arguments{
\item{x}{[any]\cr
Object to check.}

\item{y}{[\code{atomic}]\cr
Set to compare with.}

\item{ordered}{[\code{logical(1)}]\cr
Check \code{x} to have the same length and order as \code{y}, i.e.
check using \dQuote{==} while handling \code{NA}s nicely.
Default is \code{FALSE}.}

\item{fmatch}{[\code{logical(1)}]\cr
Use the set operations implemented in \code{\link[fastmatch]{fmatch}} in package \pkg{fastmatch}.
If \pkg{fastmatch} is not installed, this silently falls back to \code{\link[base]{match}}.
\code{\link[fastmatch]{fmatch}} modifies \code{y} by reference:
A hash table is added as attribute which is used in subsequent calls.}

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
 \code{assertSubset}/\code{assert_subset} return 
 \code{x} invisibly, whereas
 \code{checkSubset}/\code{check_subset} and 
 \code{testSubset}/\code{test_subset} return 
 \code{TRUE}.
 If the check is not successful, 
 \code{assertSubset}/\code{assert_subset}
 throws an error message, 
 \code{testSubset}/\code{test_subset}
 returns \code{FALSE},
 and \code{checkSubset}/\code{check_subset} 
 return a string with the error message.
 The function \code{expect_subset} always returns an
 \code{\link[testthat]{expectation}}.
}
\description{
Check if an argument is equal to a given set
}
\note{
The object \code{x} must be of the same type as the set w.r.t. \code{\link[base]{typeof}}.
Integers and doubles are both treated as numeric.
}
\examples{
testSetEqual(c("a", "b"), c("a", "b"))
testSetEqual(1:3, 1:4)

# x is not converted before the comparison (except for numerics)
testSetEqual(factor("a"), "a")
testSetEqual(1, "1")
testSetEqual(1, as.integer(1))
}
\seealso{
Other set: 
\code{\link{checkChoice}()},
\code{\link{checkDisjunct}()},
\code{\link{checkPermutation}()},
\code{\link{checkSubset}()}
}
\concept{set}
