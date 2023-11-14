ui <- bslib::page_navbar(
  title = "Sidebar updates",
  id = "nav",
  sidebar = bslib::sidebar(
    id = "sidebar",
    open = FALSE,
    "Sidebar"
  ),
  bslib::nav_panel("Page 1", "Sidebar closed. Go to Page 2 to open."),
  bslib::nav_panel("Page 2", "Sidebar open. Go to Page 1 to close.")
)

server <- function(input, output) {
  shiny::observe({
    bslib::sidebar_toggle(
      id = "sidebar",
      open = input$nav == "Page 2"
    )
  })
}

shiny::shinyApp(ui, server)
