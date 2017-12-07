# Execute upon loading.

ct <- NULL
ourColorSpace <- NULL
alternateColorSpace <- NULL

#' @import V8 colorspace stats methods scales grDevices
.onLoad <- function(libname, pkgname){
  ct <<- v8()
  ct$source(system.file("js/randomColor.js", package=pkgname))

  # Compute a 2000 color spectrum and convert to LAB
  n <- 2e3
  ourColorSpace <<- colorspace::RGB(runif(n), runif(n), runif(n))
  ourColorSpace <<- as(ourColorSpace, "LAB")

  # Alternate color palette
  alternateColorSpace <<- t(unique(col2rgb(hue_pal(l=60:100)(n))))
}
