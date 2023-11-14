#' bslib (basic)
#'
#' @return Shiny app object
#'
#' @export
#'
bslib_basic <- function() {
  shiny::shinyAppDir(system.file("examples", "01_basic", package = "bslibexamples"))
}
