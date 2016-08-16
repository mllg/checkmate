#' @details
#'
#' \describe{
#'   \item{Homepage:}{\url{https://github.com/mllg/checkmate}}
#' }
#' @import backports
#' @importFrom utils head tail
"_PACKAGE"

.onUnload <- function (libpath) {
  library.dynam.unload("checkmate", libpath) # nocov
}
