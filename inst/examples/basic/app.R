library(bslib)
library(shiny)
library(Lahman)

ui <- function() {
  shiny::tagList(
      bslib::page_sidebar(
        title = "Lahman dashboard",
        sidebar = sidebar(
          title = "Histogram controls",
          mod_data_ui("vars")
        ),
      bslib::card(
        bslib::card_header("Histogram"),
        mod_plot_ui("plot")
      )
    )
  )
}


server <- function(input, output, session) {

  x <- mod_data_server('vars')

  mod_plot_server("plot", vals = x)

}

basic_app <- function(options = list()) {
  shiny::shinyApp(
        ui = ui,
        server = server,
        options = options
      )
}
basic_app()
