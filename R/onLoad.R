#' Execute upon loading.
#' @import V8 colorspace

ct <- NULL
ourColorSpace <- NULL

.onLoad <- function(libname, pkgname){
  ct <<- v8()
  ct$source("js/randomColor.js")

  # Compute a 30000 color spectrum and convert to LAB
  ourColorSpace <<- colorspace::RGB(runif(30000), runif(30000), runif(30000))
  ourColorSpace <<- as(ourColorSpace, "LAB")
}
