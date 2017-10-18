# checkmate

[![CRAN_Status_Badge](http://www.r-pkg.org/badges/version/checkmate)](https://cran.r-project.org/package=checkmate)
[![Build Status](https://travis-ci.org/mllg/checkmate.svg?branch=master)](https://travis-ci.org/mllg/checkmate)
[![Build status](https://ci.appveyor.com/api/projects/status/y4ayps61hjd3375o/branch/master?svg=true)](https://ci.appveyor.com/project/mllg/checkmate/branch/master)
[![Coverage Status](https://img.shields.io/coveralls/mllg/checkmate.svg)](https://coveralls.io/r/mllg/checkmate?branch=master)
[![Download Stats](http://cranlogs.r-pkg.org/badges/checkmate)](https://cran.r-project.org/package=checkmate)

Fast and versatile argument checks for R.

Ever used an R function that produced a not-very-helpful error message,
just to discover after minutes of debugging that you simply passed a wrong argument?

Blaming the laziness of the package author for not doing such standard checks
(in a dynamically typed language such as R) is at least partially unfair, as R makes theses types of checks
cumbersome and annoying. Well, that's how it was in the past.

Enter checkmate.

Virtually **every standard type of user error** when passing arguments into function can be
caught with a simple, readable line which produces an **informative error message** in case.
A substantial part of the package was written in C to **minimize any worries about execution time overhead**.
Furthermore, the package provides over 30 expectations to extend the popular [testthat package](https://cran.r-project.org/package=testthat) for unit tests.


## Installation
For the stable release, just install the latest version from [CRAN](https://cran.r-project.org/package=checkmate):
```{R}
install.packages("checkmate")
```
For the development version, use [devtools](https://cran.r-project.org/package=devtools):
```{R}
devtools::install_github("mllg/checkmate")
```

## Resources
* [R Journal Paper](https://journal.r-project.org/archive/2017/RJ-2017-028/index.html)
* [NEWS](https://github.com/mllg/checkmate/blob/master/NEWS.md)
* [Documentation/Vignettes](https://mllg.github.io/checkmate/)
* [Grouped function reference](https://mllg.github.io/checkmate/reference/checkmate-package)
