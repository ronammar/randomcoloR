# Author: Ron Ammar
# Description: Get pretty random colors in R. Wraps randomColor.js.

#' Get a pretty random color.
#'
#' @param count number of colors (>= 1)
#' @param hue The hue of the colors to be selected.
#' @param luminosity The luminosity of the colors to be selected.
#' @return A character vector of random color hexadecimal codes.
#' @examples
#' randomColor()
#'
#' randomColor(hue="pink")
#'
#' randomColor(10, luminosity="light")
#' @export
#' @import stringr
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


randomColorPalette <-function(k=1) {
}
