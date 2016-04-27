#' Partial Argument Matching
#'
#' @description
#' This is an extensions to \code{\link[base]{match.arg}} with support for \code{\link{AssertCollection}}.
#' The behaviour is very similar to \code{\link[base]{match.arg}}, except that \code{NULL} is not
#' a valid value for \code{x}.
#'
#' @param x [character]\cr
#'  User provided argument to match.
#' @param choices [character()]\cr
#'  Candidates to match \code{x} with.
#' @param several.ok [logical(1)]\cr
#'  If \code{TRUE}, multiple matches are allowed, cf. \code{\link[base]{match.arg}}.
#' @template add
#' @template var.name
#' @return Subset of \code{choices}.
#' @export
#' @examples
#' matchArg("k", choices = c("kendall", "pearson"))
matchArg = function(x, choices, several.ok = FALSE, .var.name = vname(x), add = NULL) {
  assertCharacter(choices, min.len = 1L)
  assertFlag(several.ok)

  if (several.ok) {
    if (identical(x, choices))
      return(x)
    assertCharacter(x, min.len = 1L, .var.name = .var.name, add = add)
    x = choices[pmatch(x, choices, nomatch = 0L, duplicates.ok = TRUE)]
    assertSubset(x, choices, empty.ok = FALSE, .var.name = .var.name, add = add)
  } else {
    if (identical(x, choices))
      return(x[1L])
    assertCharacter(x, len = 1L, .var.name = .var.name, add = add)
    x = choices[pmatch(x, choices, nomatch = 0L, duplicates.ok = FALSE)]
    assertChoice(x, choices, .var.name = .var.name, add = add)
  }
  x
}
