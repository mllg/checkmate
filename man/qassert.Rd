\name{qassert}
\alias{qassert}
\alias{qcheck}
\title{Argument checks on (builtin) R types}
\usage{
qassert(x, rules, .var.name)

qcheck(x, rules)
}
\arguments{
  \item{x}{[ANY]\cr Object the check.}

  \item{rules}{[\code{character}]\cr Set of rules. See
  details.}

  \item{.var.name}{[\code{logical(1)}]\cr Argument name to
  print in error message. If missing, the name of \code{x}
  will be retrieved via \code{\link[base]{substitute}}.}
}
\value{
[logical(1)]: \code{TRUE} on success, \code{FALSE} (or a
thrown exception) otherwise.
}
\description{
The provided functions parse rules which allow to express
some of the most frequent argument checks by typing just a
few letters.
}
\details{
\code{qassert} throws an \code{R} exception if object
\code{x} does not comply to at least one of the
\code{rules} and returns \code{TRUE} otherwise.
\code{qcheck} behaves the same way but returns \code{FALSE}
if none of the \code{rules} comply.

The rule is specified in up to three parts. \enumerate{
\item{ Class and missingness check.  The first letter is an
abbreviation for the class. If it is provided uppercase,
missing values are prohibited.  Supported abbreviations:
\tabular{rl}{ \code{[bB]} \tab Bool / logical.\cr
\code{[iI]} \tab Integer.\cr \code{[xX]} \tab Integerish
(numeric convertible to integer, see
\code{\link{check_integerish}}).\cr \code{[rR]} \tab Real /
double.\cr \code{[cC]} \tab Complex.\cr \code{[nN]} \tab
Numeric (integer or double).\cr \code{[sS]} \tab String /
character.\cr \code{[aA]} \tab Atomic.\cr \code{[lL]} \tab
List. Missingness is defined as \code{NULL} element.\cr
\code{[mM]} \tab Matrix.\cr \code{[dD]} \tab Data.frame.
Missingness is checked recursively on columns.\cr
\code{[e]} \tab Environment.\cr \code{[f]} \tab
Function.\cr \code{[0]} \tab \code{NULL}.\cr \code{[*]}
\tab placeholder to allow any type.  } Note that the check
for missingness does not distinguish between \code{NaN} and
\code{NA}. Infinite values are not treated as missing, but
can be catched using boundary checks (part 3).  } \item{
Length definition. This can be one of \tabular{rl}{
\code{[*]} \tab any length,\cr \code{[?]} \tab length of
zero or one,\cr \code{[+]} \tab length of at least one,
or\cr \code{[0-9]+} \tab exact length specified as integer.
} Preceeding the exact length with one of the comparison
operators \code{=}/\code{==}, \code{<}, \code{<=},
\code{>=} or \code{>} is also supported.  } \item{ Range
check as two numbers separated by a comma, enclosed by
square brackets (endpoint included) or parentheses
(endpoint excluded).  For example, \dQuote{[0, 3)} would
trigger the check \code{all(x >= 0 & x < 3)}.  Endpoints
may be omitted which is the equivalent of an infinite
endpoint.  By definition \code{[0,]} contains \code{Inf},
while \code{[0,)} does not.  The same holds for the left
(lower) endpoint and \code{-Inf}.  E.g., the rule
\dQuote{N1()} checks for a single finite numeric which is
not NA, while \dQuote{N1[)} would allow \code{-Inf}.  } }
}
\note{
The functions are inspired by the blog post of Bogumił
Kamiński:
\url{http://rsnippets.blogspot.de/2013/06/testing-function-agruments-in-gnu-r.html}.
The implementation is mostly written in \code{C} to
minimize the overhead.
}
\examples{
# logical of length 1
qcheck(NA, "b1")

# logical of length 1, NA not allowed
qcheck(NA, "B1")

# logical of length 0 or 1, NA not allowed
qcheck(TRUE, "B?")

# numeric with length > 0
qcheck(runif(10), "n+")

# integer with length > 0, NAs not allowed, all integers >= 0 and < Inf
qcheck(1:3, "I+[0,)")

# either an emtpy list or a character vector with <=5 elements
qcheck(1, c("l0", "s<=5"))
# data frame with at least one column, no NA in any column
qcheck(iris, "D+")
}
\seealso{
\code{\link{qcheckr}} and \code{\link{qassertr}} for
efficient checks of list elements and data frame columns.
}

