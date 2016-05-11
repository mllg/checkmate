#' @details
#'
#' \describe{
#'   \item{Homepage:}{\url{https://github.com/mllg/checkmate}}
#' }
#' @import backports
#' @importFrom utils head tail
#' @importFrom tools file_ext
"_PACKAGE"

.onUnload <- function (libpath) {
  library.dynam.unload("checkmate", libpath) # nocov
}
