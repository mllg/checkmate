\name{check_class}
\alias{check_class}
\title{Check argument inheritance}
\usage{
check_class(x, classes, ordered = FALSE)
}
\arguments{
  \item{x}{[ANY]\cr Object to check.}

  \item{classes}{[\code{character}]\cr Class names to check
  for inheritance.}

  \item{ordered}{[\code{logical(1)}]\cr Expect \code{x} to
  be specialized in provided order.  Default is
  \code{FALSE}.}
}
\value{
Returns \code{TRUE} on success and an error message
otherwise.  Intended to be used with \code{\link{test}},
\code{\link{assert}} or \code{\link{pass}}.
}
\description{
Check argument inheritance
}
\examples{
# Create an object with classes "foo" and "bar"
 x = 1
 class(x) = c("foo", "bar")

 # is x of class "foo"?
 test(x, "class", "foo")

 # is x of class "foo" and "bar"?
 test(x, "class", c("foo", "bar"))

 # is x most specialized as "bar"?
 test(x, "class", "bar", ordered = TRUE)
}

