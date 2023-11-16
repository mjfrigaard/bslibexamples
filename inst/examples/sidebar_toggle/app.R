ui <- bslib::page_navbar(
  title = "Sidebar updates",
  id = "nav",
  sidebar = bslib::sidebar(
    id = "sidebar",
    open = FALSE,
    "Sidebar"
  ),
  bslib::nav_panel("Page 1",
    "Sidebar closed. Go to Page 2 to open.",
    shiny::verbatimTextOutput("p1_vals")
    ),
  bslib::nav_panel("Page 2",
    "Sidebar open. Go to Page 1 to close.",
    shiny::verbatimTextOutput("p2_vals")
    )
)

server <- function(input, output) {

  rVals <- shiny::reactiveValues()

  rVals$vals <- shiny::reactive({
    shiny::reactiveValuesToList(input, all.names = TRUE)
  })

  output$p1_vals <- shiny::renderPrint({
      rVals$vals()
  })

  output$p2_vals <- shiny::renderPrint({
      rVals$vals()
  })

  shiny::observe({

    bslib::sidebar_toggle(
      id = "sidebar",
      open = input$nav == "Page 2"
    )

  })

}

shiny::shinyApp(ui, server)
