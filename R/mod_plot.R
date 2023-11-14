#' Module (plot) UI
#'
#' @param id module id
#'
#' @return module UI function
#' @export
#'
mod_plot_ui <- function(id) {
  ns <- shiny::NS(id)
    shiny::tagList(
      shiny::plotOutput(ns("p")),
      shiny::verbatimTextOutput(ns("vals"))
    )
}

#' Module (plot) server
#'
#' @param id module id
#' @param vals reactive values from `mod_data_server()`
#' @param .dev view reactive inputs
#'
#' @return module server function
#'
#' @export
#'
mod_plot_server <- function(id, vals, .dev = FALSE) {

  shiny::moduleServer(id, function(input, output, session) {
    ns <- session$ns

    d <- shiny::reactive({
          get(x = vals()$data, pos = "package:Lahman")
         }) |>
            bindEvent(vals()$data)


    if (.dev) {
    output$vals <- renderPrint({
      list(
        vals()$data,
        vals()$var,
        vals()$bins
        )
    })
    }


    shiny::observe({
    output$p <- shiny::renderPlot({
      if (vals()$var %in% names(d())) {
          hist_plot(df = d(),
            x_var = vals()$var,
            bins_var = vals()$bins)
      }
    })
    }) # |>
    # bindEvent(d(), vals()$var, vals()$bin)

  })
}
# Copy in UI
# mod_plot_ui("id")
# Copy in server
# mod_plot_server("id")
