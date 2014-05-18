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

#FIXME: flag might be a bad name

#' \code{aflag}: Assert a boolean non-NA flag.
#' @rdname assert_syntactic_sugar
#' @export
aflag = function(x) {
  assert(x, "flag")
}

#' \code{anum}: Assert a numeric non-NA scalar.
#' @rdname assert_syntactic_sugar
#' @export
anum = function(x, upper = Inf) {
  assert(x, "numeric", upper = upper)
}

#' \code{anump}: Assert a positive numeric non-NA scalar.
#' @rdname assert_syntactic_sugar
#' @export
anump = function(x, upper = Inf) {
  assert(x, "numeric", upper = upper)
}


#' \code{aint}: Assert a integerish non-NA scalar.
#' @rdname assert_syntactic_sugar
#' @export
aint = function(x) {
  assert(x, "integerish")
}

#FIXME: both acount functions need check_count to be improved first

#' \code{acount0}: Assert a non-NA count >= 0.
#' @rdname assert_syntactic_sugar
#' @export
acount0 = function(x, upper) {
  assert(x, "count")
}

#' \code{acount1}: Assert a non-NA count >= 1.
#' @rdname assert_syntactic_sugar
#' @export
acount1 = function(x, upper) {
  assert(x, "count")
}

#' \code{astring}: Assert a non-NA string.
#' @rdname assert_syntactic_sugar
#' @export
astring = function(x) {
  assert(x, "string")
}

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

#' \code{achoice}: Assert an object that matches exactly one of the given atomic choices.
#' @rdname assert_syntactic_sugar
#' @export
achoice = function(x, choices) {
  assert(x, "choice", choices = choices)
}


########## vectors

#' \code{anumvec}: Assert an non-NA numeric vector.
#' @rdname assert_syntactic_sugar
#' @export
anumvec = function(x) {
  assert(x, "numeric")
}

#' \code{aintvec}: Assert an non-NA integerish vector.
#' @rdname assert_syntactic_sugar
#' @export
aintvec = function(x) {
  assert(x, "integerish")
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


