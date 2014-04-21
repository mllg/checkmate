library(microbenchmark)
library(devtools)
load_all("..")


bm = function(...) {
  print(microbenchmark("own" = ..1, "alternative" = ..2),
    unit="relative", order="median")
}

x = 1:10
bm(qcheck(x, "i+"), is.integer(x) && length(x))
bm(qcheck(x, "i+[1,)"), is.integer(x) && length(x) && all(x >= 1L))

x = 1.
bm(qcheck(x, "N1"), test(numeric, x, len=1L))
