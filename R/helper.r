makeCheckReturn = function(msg) {
  !nzchar(msg)
}

makeAssertReturn = function(msg) {
  if (nzchar(msg))
    stop(msg)
  invisible(TRUE)
}
