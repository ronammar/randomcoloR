#' @import V8
ct <- NULL
.onLoad <- function(libname, pkgname){
  ct <<- v8()
  ct$source("js/randomColor.js")
}
