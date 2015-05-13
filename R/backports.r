if (getRversion() < "3.2.0") {
  dir.exists = function(paths) {
    x = file.info(paths)$isdir
    !is.na(x) & x
  }
}
