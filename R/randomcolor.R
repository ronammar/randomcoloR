# Author: Ron Ammar
# Description: Get pretty random colors in R. Wraps randomColor.js.

library(stringr)
library(V8)

ct <- v8()
ct$source("js/randomColor.js")

randomColor <- function(count=1,
                         hue=c(" ", "random", "red", "orange", "yellow", "green", "blue", "purple", "pink", "monochrome"),
                         luminosity=c(" ", "random", "light", "bright", "dark")
) {
  hue <- match.arg(hue)
  luminosity <- match.arg(luminosity)

  str_split(ct$eval(paste0("randomColor({hue:'", hue, "',",
                           "luminosity:'", luminosity,"',",
                           "count:", count,"})")
  ), ",")[[1]]
}

# randomColorPalette(k=1) {
#}
