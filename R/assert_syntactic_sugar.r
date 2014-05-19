#' Syntactic sugar to make the most common asserts as simple as possible.
#'
#' @param x [any]\cr
#'   The object we assert something about.
#' @param args [\code{character}]\cr
#'   See \code{\link{check_function}}.
#' @param types [\code{character}]\cr
#'   See \code{\link{check_list}}.
#' @param choices [\code{atomic}]\cr
#'   See \code{\link{check_choice}}.
#' @param lower [\code{numeric} | \code{integer}]\cr
#'   See \code{\link{check_numeric}} and \code{\link{check_integerish}}.
#' @param upper [\code{numeric} | \code{integer}]\cr
#'   See \code{\link{check_numeric}} and \code{\link{check_integerish}}.
#' @param classes [\code{character}]\cr
#'   See \code{\link{check_class}}.
#' @return If the assertion is not passed, an exception is thrown with an informative error message.
#'   Other \code{x} is returned, possibly SLIGHTLY converted to a correct class.
#'   Currently this means to convert integerish numbers to true integers.
#'
#' @name assert_syntactic_sugar
#' @rdname assert_syntactic_sugar
NULL

########## scalars / single objects

#' \code{aflag, alog}: Assert a boolean non-NA flag.
#' @rdname assert_syntactic_sugar
#' @export
alog = aflag = function(x) {
  assert(x, "flag")
}

#' \code{anum}: Assert a numeric non-NA scalar.
#' @rdname assert_syntactic_sugar
#' @export
anum = function(x, lower = -Inf, upper = Inf) {
  assert(x, "numeric", len = 1L, any.missing = FALSE, lower = lower, upper = upper)
}

#' \code{anump}: Assert a positive numeric non-NA scalar.
#' @rdname assert_syntactic_sugar
#' @export
anump = function(x, upper = Inf) {
  assert(x, "numeric", len = 1L, any.missing = FALSE, lower = 0, upper = upper)
}


#' \code{aint}: Assert a integerish non-NA scalar.
#' @rdname assert_syntactic_sugar
#' @export
aint = function(x) {
  assert(x, "integerish", len = 1L, any.missing = FALSE)
}

# FIXME:  maybe aintp is more consistent?

#' \code{acount0}: Assert a non-NA count >= 0.
#' @rdname assert_syntactic_sugar
#' @export
acount0 = function(x, upper) {
  assert(x, "integerish" , lower = 0L, len = 1L, any.missing = FALSE)
}

#' \code{acount1}: Assert a non-NA count >= 1.
#' @rdname assert_syntactic_sugar
#' @export
acount1 = function(x, upper) {
  assert(x, "integerish" , lower = 1L, len = 1L, any.missing = FALSE)
}

#' \code{astring, achar}: Assert a non-NA string.
#' @rdname assert_syntactic_sugar
#' @export
achar = astring = function(x) {
  assert(x, "string")
}

########## vectors

#' \code{alogvec}: Assert an non-NA logical vector.
#' @rdname assert_syntactic_sugar
#' @export
alogvec = function(x) {
  assert(x, "logical", any.missing = FALSE)
}

#' \code{anumvec}: Assert an non-NA numeric vector.
#' @rdname assert_syntactic_sugar
#' @export
anumvec = function(x, lower = -Inf, upper = Inf) {
  assert(x, "numeric", lower = lower, upper = upper, any.missing = FALSE)
}

#' \code{aintvec}: Assert an non-NA integerish vector.
#' @rdname assert_syntactic_sugar
#' @export
aintvec = function(x, lower = -Inf, upper = Inf) {
  assert(x, "integerish", lower = lower, upper = upper, any.missing = FALSE)
}

#' \code{acharvec}: Assert an non-NA character vector.
#' @rdname assert_syntactic_sugar
#' @export
acharvec = function(x) {
  assert(x, "character", any.missing = FALSE)
}

#' \code{afactor}: Assert an non-NA factor.
#' @rdname assert_syntactic_sugar
#' @export
afactor = function(x) {
  assert(x, "factor", any.missing = FALSE)
}

########## object and function

#' \code{afun}: Assert a function.
#' @rdname assert_syntactic_sugar
#' @export
afun = function(x, args) {
  #FIXME: again I am not sure why I need to do this and it sucks
  if (missing(args))
    assert(x, "function")
  else
    assert(x, "function", args = args)
}

#' \code{aobj}: Assert an object that is of at least one of the given classes.
#' @rdname assert_syntactic_sugar
#' @export
aobj = function(x, classes) {
  assert(x, "class", classes = classes)
}

########## choice and subset

#' \code{achoice}: Assert an object that matches exactly one of the given atomic choices.
#' @rdname assert_syntactic_sugar
#' @export
achoice = function(x, choices) {
  assert(x, "choice", choices = choices)
}

#FIXME: allow empty subset? specialiazation?

#' \code{asubset}: Assert that we have a subset of some atomic choices.
#' @rdname assert_syntactic_sugar
#' @export
asubset = function(x, choices) {
  assert(x, "subset", choices = choices)
}

########## lists

#' \code{alist}: Assert a list.
#' @rdname assert_syntactic_sugar
#' @export
alist = function(x, types) {
  assert(x, "list", types = types)
}

#' \code{alistn}: Assert a list, named.
#' @rdname assert_syntactic_sugar
#' @export
alistn = function(x, types) {
  #FIXME: see afun dreck
  if (missing(types))
    assert(x, "list", names = "named")
  else
    assert(x, "list", types = types, names = "named")
}

#' \code{alistnu}: Assert a list, uniquely named.
#' @rdname assert_syntactic_sugar
#' @export
alistnu = function(x, types) {
  if (missing(types))
    assert(x, "list", names = "unique")
  else
    assert(x, "list", types = types, names = "unique")
}

########## file io

#' \code{afile}: Assert an existing file path.
#' @rdname assert_syntactic_sugar
#' @export
afile = function(x) {
  assert(x, "file")
}

#' \code{adir}: Assert an existing directory path.
#' @rdname assert_syntactic_sugar
#' @export
adir = function(x) {
  assert(x, "directory")
}


