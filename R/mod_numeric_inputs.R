#' input shiny module (UI)
#'
#' @param id shiny module id
#'
#' @export
mod_numeric_inputs_ui <- function(id) {
  ns <- shiny::NS(id)
    shiny::tagList(
      shiny::numericInput(inputId = ns('num'), label = "numeric input",
        value = 5,
        min = 0,
        max = 10),
      shiny::sliderInput(inputId = ns("slide_num"), label = "slider input",
        min = 0,
        max = 10,
        value = 5,
        step = 1),
      shiny::verbatimTextOutput(ns("dev"))
    )
  }
#' input shiny module (server)
#'
#' @param id shiny module id
#' @param .dev view output from `reactiveValuesToList()`?
#'
#' @export
#'
mod_numeric_inputs_server <- function(id, .dev = FALSE) {
  shiny::moduleServer(id, function(input, output, session) {
    ns <- session$ns

    if (.dev) {
      output$dev <- shiny::renderPrint({
        shiny::reactiveValuesToList(input, all.names = TRUE)
      })
    }

    return(
      shiny::reactive({
        shiny::reactiveValuesToList(input, all.names = TRUE)
      })
    )

  })
}
# Copy in UI
# mod_numeric_input_ui("id")
# Copy in server
# mod_numeric_input_server("id")



