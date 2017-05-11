library(data.table)
library(stringi)
library(ggplot2)

path = "mem-logs"
logs = list.files(path)

groups = c("checkmate", "qcheckmate", "R", "assertthat", "assertive", "noop")
result = data.table(impl = character(0), mem = double(0))

for (gr in groups) {
  fns = logs[stri_detect_fixed(logs, stri_join("-", gr))]
  mem = sapply(fns, function(fn) {
    as.integer(stri_extract_last_regex(tail(readLines(file.path(path, fn)), 1L), "\\d+"))
  }, USE.NAMES = FALSE)
  result = rbind(result, data.table(impl = gr, mem = mem / 10^6))
}

result[, .N, by = impl]
print(result[, list(mean = round(mean(mem), 2), sd = round(sd(mem), 2)), by = impl])
