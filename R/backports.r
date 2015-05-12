if (getRversion() < "3.2") {
  dir.exists = function(paths) {
    x = file.info(c("/tmp2", "/tmp"))$isdir
    !is.na(x) & x
  }
}
