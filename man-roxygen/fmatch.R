#' @param fmatch [\code{logical(1)}]\cr
#'  Use the set operations implemented in \code{\link[fastmatch]{fmatch}} in package \pkg{fastmatch}.
#'  If \pkg{fastmatch} is not installed, this silently falls back to \code{\link[base]{match}}.
#'  \code{\link[fastmatch]{fmatch}} modifies \code{y} by reference:
#'  A hash table is added as attribute which is used in subsequent calls.
