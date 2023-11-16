#' Shiny app display mode helper
#'
#' @param run where to launch app:
#'  * `"p"` = launch in viewer pane
#'  * `"b"` = launch in external browser
#'  * `"w"` = launch in window (default)
#'
#' @return notification of `shinyViewerType` option
#'
#' @export
#'
display_type <- function(run = "w") {
  if (run == "p") {
    options(shiny.launch.browser = .rs.invokeShinyPaneViewer)
  } else if (run == "b") {
    options(shiny.launch.browser = .rs.invokeShinyWindowExternal)
  } else if (run == "w") {
    options(shiny.launch.browser = .rs.invokeShinyWindowViewer)
  } else {
    options(shiny.launch.browser = NULL)
  }
    shinyViewerType <- getOption('shiny.launch.browser') |>
                        attributes() |>
                        unlist() |>
                        unname()
    cli::cli_alert_info("shinyViewerType set to {shinyViewerType}")
}

#' Launch bslib (examples)
#'
#' @param app one of:
#' * `"basic"`
#' * `"nested_sidebar"`
#' * `"sidebar_toggle"`
#' * `"sidebar_cond_panel"`
#' @param run where to launch app:
#'  * `p` = launch in viewer pane
#'  * `b` = launch in external browser
#'  * `w` = launch in window
#' @param options arguments to pass to `options()`
#'
#' @return Shiny app object
#'
#' @export
#'
launch_app <- function(app, run = 'w', options = list()) {
  if (interactive()) {
    display_type(run = run)
  }
  shiny::shinyAppDir(
    system.file("examples", app,
      package = "bslibexamples"),
    options = list(display.mode = "showcase"))
}
