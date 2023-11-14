shiny::shinyApp(
  bslib::page_navbar(
    title = "Conditional sidebar",
    id = "nav",
    sidebar = bslib::sidebar(
      conditionalPanel(condition = "input.nav === 'Page 1'",
        "Page 1 sidebar"
      ),
      conditionalPanel(condition = "input.nav === 'Page 2'",
        "Page 2 sidebar"
      )
    ),
    bslib::nav_panel("Page 1", "Page 1 contents"),
    bslib::nav_panel("Page 2", "Page 2 contents")
  ),
  server = function(...) {
    # no server logic required
  }
)
