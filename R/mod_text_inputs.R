#' text_inputs shiny module (UI)
#'
#' @param id shiny module id
#'
#' @export
mod_text_inputs_ui <- function(id) {
  ns <- shiny::NS(id)
    shiny::tagList(
      shiny::textInput(inputId = ns('txt'),
        label = "text input"),
      shiny::textAreaInput(inputId = ns('area_txt'),
        label = "text area input"),
      shiny::verbatimTextOutput(ns("dev"))
    )
  }
#' text_inputs shiny module (server)
#'
#' @param id shiny module id
#'
#' @export
mod_text_inputs_server <- function(id, .dev = FALSE) {
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
# mod_text_inputs_ui("id")
# Copy in server
# mod_text_inputs_server("id")

