#' input shiny module (UI)
#'
#' @param id shiny module id
#'
#' @export
mod_inputs_ui <- function(id) {
  ns <- shiny::NS(id)
    shiny::tagList(
      shiny::textInput(inputId = ns('txt'), label = "text input")
    )
  }
#' input shiny module (server)
#'
#' @param id shiny module id
#'
#' @export
#'
mod_inputs_server <- function(id, .dev = FALSE) {
  shiny::moduleServer(id, function(input, output, session) {
    ns <- session$ns

    if (.dev) {
      shiny::renderPrint({
        vals <- shiny::reactiveValuesToList(input, all.names = TRUE)
        print(vals)
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
# mod_input_ui("id")
# Copy in server
# mod_input_server("id")



