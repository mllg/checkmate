.makeXFunction <- function(x, check.fun, c.fun, use.namespace, coerce, env) {
  x = match.arg(x, choices = c("assertion", "expectation", "test"))
  check.fun.name = if (is.character(check.fun)) as.name(check.fun) else substitute(check.fun, env = parent.frame())
  check.fun = match.fun(check.fun)
  new.fun <- local({
    new.fun.body = call("{")
    new.fun.args = check.fun.args = formals(args(check.fun))
    first.arg.name = as.name(names(check.fun.args[1L]))
    if (is.null(c.fun)) {
      inner.fun.args = lapply(names(check.fun.args), as.name)
      inner.fun.call = as.call(c(check.fun.name, inner.fun.args))
      not.dots.args.idx = which(names(check.fun.args) != "...")
      names(inner.fun.call)[not.dots.args.idx + 1L] = names(check.fun.args)[not.dots.args.idx]
    } else {
      inner.fun.args = lapply(names(check.fun.args), as.name)
      inner.fun.call = as.call(c(quote(.Call), c.fun, inner.fun.args))
    }
    new.fun.body[[length(new.fun.body) + 1L]] = call("=", quote(res), inner.fun.call)
    if (x == "test") {
      new.fun.body[[length(new.fun.body) + 1L]] = quote(isTRUE(res))
      return(list(body = new.fun.body, args = new.fun.args))
    }
    if (use.namespace) {
      .vname = quote(checkmate::vname)
      .makeX = switch(
        x,
        assertion = quote(checkmate::makeAssertion),
        expectation = quote(checkmate::makeExpectation)
      )
    } else {
      .vname = quote(vname)
      .makeX = switch(
        x,
        assertion = quote(makeAssertion),
        expectation = quote(makeExpectation)
      )
    }
    .var.name = bquote(.(.vname)(.(first.arg.name)))
    if (x == "assertion") {
      new.fun.args = c(new.fun.args, if (isTRUE(coerce)) list(coerce = FALSE) else NULL, list(.var.name = .var.name, add = NULL))
      makeX.call = bquote(.(.makeX)(x = .(first.arg.name), res = res, var.name = .var.name, collection = add))
    } else if (x == "expectation") {
      new.fun.args = c(new.fun.args, list(info = NULL, label = .var.name))
      makeX.call = bquote(.(.makeX)(x = .(first.arg.name), res = res, info = info, label = label))
    }
    new.fun.body[[length(new.fun.body) + 1L]] = makeX.call
    if (x == "expectation") {
      return(list(body = new.fun.body, args = new.fun.args))
    }
    if (isTRUE(coerce)) {
      new.fun.body[[length(new.fun.body) + 1L]] = bquote(if (isTRUE(coerce) && is.double(.(first.arg.name))) .(first.arg.name) = setNames(as.integer(round(.(first.arg.name), 0L)), names(.(first.arg.name))))
      new.fun.body[[length(new.fun.body) + 1L]] = bquote(invisible(.(first.arg.name)))
    }
    return(list(body = new.fun.body, args = new.fun.args))
  })
  eval(call("function", as.pairlist(new.fun$args), new.fun$body), envir = env)
}

makeXFunctionFactory <- function(x) {
  x = match.arg(x, choices = c("assertion", "expectation", "test"))
  switch(
    x,
    assertion = function(check.fun, c.fun = NULL, use.namespace = TRUE, coerce = FALSE, env = parent.frame()) {
      .makeXFunction(
        x = "assertion",
        check.fun = check.fun,
        c.fun = c.fun,
        use.namespace = use.namespace,
        coerce = coerce,
        env = env
      )
    },
    expectation = function(check.fun, c.fun = NULL, use.namespace = FALSE, env = parent.frame()) {
      .makeXFunction(
        x = "expectation",
        check.fun = check.fun,
        c.fun = c.fun,
        use.namespace = use.namespace,
        env = env
      )
    },
    test = function(check.fun, c.fun = NULL, env = parent.frame()) {
      .makeXFunction(
        x = "test",
        check.fun = check.fun,
        c.fun = c.fun,
        env = env
      )
    }
  )
}
