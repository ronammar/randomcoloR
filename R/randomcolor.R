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
#' @param altCol Use an alternate color space
#' @param runTsne Preprocess color space with t-SNE to obtain distinct colors. Reduces performance.
#' @return A character vector of k optimally distinct colors in hexadecimal codes.
#' @export
#' @import cluster Rtsne
distinctColorPalette <-function(k=1, altCol=FALSE, runTsne=FALSE) {
  currentColorSpace <- ourColorSpace@coords
  if (altCol) {
    currentColorSpace <- alternateColorSpace
  }

  if (runTsne) {
    # Run 2D t-SNE before clustering
    tsne <- Rtsne(currentColorSpace, perplexity=50, check_duplicates=FALSE, pca=FALSE, max_iter=500)
    pamx <- pam(tsne$Y, k)  # k-medoids
    if (altCol) {
      colors <- rgb(currentColorSpace[pamx$id.med, ], maxColorValue=255)
    } else {
      colors <- hex(LAB(currentColorSpace[pamx$id.med, ]))
    }
  } else {
    # Set iter.max to 20 to avoid convergence warnings.
    km <- kmeans(currentColorSpace, k, iter.max=20)
    if (altCol) {
      colors <- rgb(round(km$centers), maxColorValue=255)
    } else {
      colors <- unname(hex(LAB(km$centers)))
    }
  }

  return(colors)
}
