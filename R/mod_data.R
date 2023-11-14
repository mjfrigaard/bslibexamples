#' Module (data) UI
#'
#' @param id module id
#'
#' @return module UI function
#'
#' @export
#'
mod_data_ui <- function(id) {
  require(Lahman, quietly = TRUE)
  data(LahmanData, package = "Lahman")
  ds_nms <- LahmanData[['file']]
  ns <- shiny::NS(id)
    shiny::tagList(
      shiny::selectInput(ns("data"), label = "Data",
        choices = ds_nms),
      shiny::selectInput(inputId = ns("var"),
        label = "Select variable",
        choices = c(NULL, "")
        ),
        shiny::numericInput(inputId = ns("bins"),
          label = "Number of bins",
          value = 30),
      shiny::verbatimTextOutput(ns('vals'))
      )
}

#' Module (data) server
#'
#' @param id module id
#' @param .dev view reactive inputs
#'
#' @return module server function
#'
#' @export
#'
mod_data_server <- function(id, .dev = FALSE) {
  shiny::moduleServer(id, function(input, output, session) {
    ns <- session$ns

    nms <- shiny::reactive({
            get(x = input$data, pos = "package:Lahman") |>
              dplyr::select(where(is.numeric)) |>
                names()
            })

    shiny::observe({
            shiny::updateSelectInput(
                inputId = "var",
                choices = nms())
          }) |>
      shiny::bindEvent(input$data)

    if (.dev) {
      output$vals <- renderPrint({
          list(
            'data' = input$data,
            'var' = input$var,
            'bins' = input$bins
          )
      })
    }
    return(
      shiny::reactive({
        list(
          'data' = input$data,
          'var' = input$var,
          'bins' = input$bins
        )
      }) |>
        bindEvent(input$var)
    )
  })
}
# Copy in UI
# mod_var_ui("id")
# Copy in server
# mod_var_server("id")
