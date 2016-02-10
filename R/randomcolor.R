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


#' Generate palettes of optimally distinct colors.
#' @description Inspired by the the theory from http://tools.medialab.sciences-po.fr/iwanthue/theory.php
#' For more info, also see https://en.wikipedia.org/wiki/Lab_color_space
#'
#' @param k number of colors (>= 1). May be ineffective for k > 40.
#' @return A character vector of k optimally distinct colors in hexadecimal codes.
#' @export
distinctColorPalette <-function(k=1) {
  # Set iter.max to 20 to avoid convergence warnings.
  km <- kmeans(ourColorSpace@coords, k, iter.max=20)
  hex(LAB(km$centers))
}
