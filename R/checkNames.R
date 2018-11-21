#' Check names to comply to specific rules
#'
#' @description
#' Similar to \code{\link{checkNamed}} but you can pass the names directly.
#'
#' @templateVar fn Named
#' @param x [\code{character} || \code{NULL}]\cr
#'  Names to check using rules defined via \code{type}.
#' @param type [character(1)]\cr
#'  Type of formal check(s) to perform on the names.
#'  \describe{
#'  \item{unnamed:}{Checks \code{x} to be \code{NULL}.}
#'  \item{named:}{Checks \code{x} for regular names which excludes names to be \code{NA} or empty (\code{""}).}
#'  \item{unique:}{Performs checks like with \dQuote{named} and additionally tests for non-duplicated names.}
#'  \item{strict:}{Performs checks like with \dQuote{unique} and additionally fails for names with UTF-8 characters and names which do not comply to R's variable name restrictions. As regular expression, this is \dQuote{^[.]*[a-zA-Z]+[a-zA-Z0-9._]*$}.}
#'  }
#'  Note that for zero-length \code{x}, all these name checks evaluate to \code{TRUE}.
#' @param subset.of [\code{character}]\cr
#'  Names provided in \code{x} must be subset of the set \code{subset.of}.
#' @param must.include [\code{character}]\cr
#'  Names provided in \code{x} must be a superset of the set \code{must.include}.
#' @param permutation.of [\code{character}]\cr
#'  Names provided in \code{x} must be a permutation of the set \code{permutation.of}.
#'  Duplicated names in \code{permutation.of} are stripped out and duplicated names in \code{x}
#'  thus lead to a failed check.
#'  Use this argument instead of \code{identical.to} if the order of the names is not relevant.
#' @param identical.to [\code{character}]\cr
#'  Names provided in \code{x} must be identical to the vector \code{identical.to}.
#'  Use this argument instead of \code{permutation.of} if the order of the names is relevant.
#' @param disjunct.from [\code{character}]\cr
#'  Names provided in \code{x} must may not be present in the vector \code{identical.to}.
#' @template checker
#' @useDynLib checkmate c_check_names
#' @family attributes
#' @export
#' @examples
#' x = 1:3
#' testNames(x, "unnamed")
#' names(x) = letters[1:3]
#' testNames(x, "unique")
#'
#' cn = c("Species", "Sepal.Length", "Sepal.Width", "Petal.Length", "Petal.Width")
#' assertNames(names(iris), permutation.of = cn)
checkNames = function(x, type = "named", subset.of = NULL, must.include = NULL, permutation.of = NULL, identical.to = NULL, disjunct.from = NULL) {
  .Call(c_check_names, x, type) %and%
    checkNamesCmp(x, subset.of, must.include, permutation.of, identical.to, disjunct.from)
}

checkNamesCmp = function(x, subset.of, must.include, permutation.of, identical.to, disjunct.from) {
  if (!is.null(subset.of)) {
    qassert(subset.of, "S")
    if (anyMissing(match(x, subset.of)))
      return(sprintf("Must be a subset of set {%s}", paste0(subset.of, collapse = ",")))
  }
  if (!is.null(must.include)) {
    qassert(must.include, "S")
    if (anyMissing(match(must.include, x)))
      return(sprintf("Must include the elements {%s}", paste0(must.include, collapse = ",")))
  }
  if (!is.null(permutation.of)) {
    permutation.of = unique(qassert(permutation.of, "S"))
    if (length(x) != length(permutation.of) || !setequal(x, permutation.of))
      return(sprintf("Must be a permutation of set {%s}", paste0(permutation.of, collapse = ",")))
  }
  if (!is.null(identical.to)) {
    qassert(identical.to, "S")
    if (!identical(x, identical.to))
      return(sprintf("Must be a identical to (%s)", paste0(identical.to, collapse = ",")))
  }
  if (!is.null(disjunct.from)) {
    if (any(x %in% disjunct.from))
      return(sprintf("Must be disjunct from (%s)", paste0(disjunct.from, collapse = ",")))
  }
  return(TRUE)
}

#' @export
#' @rdname checkNames
check_names = checkNames

#' @export
#' @include makeAssertion.R
#' @template assert
#' @rdname checkNames
assertNames = makeAssertionFunction(checkNames, use.namespace = FALSE)

#' @export
#' @rdname checkNames
assert_names = assertNames

#' @export
#' @include makeTest.R
#' @rdname checkNames
testNames = makeTestFunction(checkNames)

#' @export
#' @rdname checkNames
test_names = testNames

#' @export
#' @include makeExpectation.R
#' @template expect
#' @rdname checkNames
expect_names = makeExpectationFunction(checkNames, use.namespace = FALSE)
