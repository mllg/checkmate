# checkmate

Fast and versatile argument checks for R.

* Travis CI: [![Build Status](https://travis-ci.org/mllg/checkmate.svg)](https://travis-ci.org/mllg/checkmate)


Ever used an R function that produced a not very helpful message, just to discover minutes later that you simply passed a wrong argument? 
Blaming the laziness of the package author for not doing such a standard check (in a weakly typed language such as R) is at least partially unfair, as R makes theses types of checks cumbersome and annoying. Well, that's how it was in the past. Enter checkmate. Virtaually every standard type of user error when passing arguments into function can be caiught with a simple, readable line which produces an informative error message in case. A substantial part of the package was written in C to minimize any worries about execution time overhead. 





