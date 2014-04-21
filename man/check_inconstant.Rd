\name{check_inconstant}
\alias{check_inconstant}
\title{Check if elements of a vector are variable}
\usage{
check_inconstant(x, tol = .Machine$double.eps^0.5)
}
\arguments{
  \item{x}{[\code{ANY}]\cr Object to check.}

  \item{tol}{[\code{double(1)}]\cr Numerical tolerance used
  if \code{x} is of type \code{double} or \code{complex}.
  Default is \code{sqrt(.Machine$double.eps)}.}
}
\value{
Returns \code{TRUE} on success and an error message
otherwise.  Intended to be used with \code{\link{test}},
\code{\link{assert}} or \code{\link{pass}}.
}
\description{
Check if elements of a vector are variable
}
\examples{
test(c(1, NA), "inconstant")

x = c(0, 1 - 0.9 - 0.1)
print(identical(x[1], x[2]))
print(test(x, "inconstant"))
}
\seealso{
Other checker: \code{\link{check_character}};
\code{\link{check_class}}; \code{\link{check_constant}};
\code{\link{check_count}}; \code{\link{check_data.frame}};
\code{\link{check_directory}}; \code{\link{check_factor}};
\code{\link{check_file}}; \code{\link{check_flag}};
\code{\link{check_fun}}; \code{\link{check_integerish}};
\code{\link{check_integer}}; \code{\link{check_list}};
\code{\link{check_logical}}; \code{\link{check_matrix}};
\code{\link{check_named}}; \code{\link{check_numeric}};
\code{\link{check_vector}}
}

