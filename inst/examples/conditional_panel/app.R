ui <- function() {
  bslib::page_navbar(
    title = "App info",
    id = "nav",
    # sidebar = bslib::sidebar("Sidebar"),
    bslib::nav_panel(title = "welcome"),
    bslib::nav_panel(
      title = "model info",
      bslib::navset_card_tab(
        sidebar = bslib::sidebar(
          "General parameters",
          code("global_sample"),
          code("regional_sample"),
          code("randomization"),
        ),
        bslib::nav_panel(
          title = "Binomial model",
          "Binomial parameters"
        ),
        bslib::nav_panel(
          title = "Normal model",
          "Normal parameters"
        ),
        bslib::nav_panel(
          title = "Negative binomial model",
          "Negative binomial parameters"
        )
      )
    ),
    bslib::nav_panel(
      title = "results",
      bslib::navset_card_tab(
        title = "outputs",
        sidebar = bslib::sidebar(
          "General parameters",
          code("graph options"),
          code("tables options")
        ),
        bslib::nav_panel(
          title = "Graphs",
          code("graphs")
        ),
        bslib::nav_panel(
          title = "Tables",
          code("tables")
        ),
      )
    ),
  )
}

server <- function(input, output, session) {
  rVals <- shiny::reactiveValues()
  rVals$all_vals <- shiny::reactive({
    shiny::reactiveValuesToList(input, all.names = TRUE)
  })
}

shiny::shinyApp(ui = ui, server = server)
