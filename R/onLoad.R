# Execute upon loading.

ct <- NULL
ourColorSpace <- NULL
alternateColorSpace <- NULL

#' @import V8 colorspace stats methods scales grDevices
.onLoad <- function(libname, pkgname){
  ct <<- v8()
  ct$source(system.file("js/randomColor.js", package=pkgname))

  # Compute a 30000 color spectrum and convert to LAB
  ourColorSpace <<- colorspace::RGB(runif(30000), runif(30000), runif(30000))
  ourColorSpace <<- as(ourColorSpace, "LAB")

  # Alternate color palette
  alternateColorSpace <<- t(unique(col2rgb(hue_pal(l=60:100)(1e3))))
}
