
ui <- function() {
  bslib::page_fillable(
    shiny::h1("Left and right sidebar",
      class = "px-3 my-3"),
    bslib::layout_sidebar(
      sidebar = bslib::sidebar("Left sidebar"),
      bslib::layout_sidebar(
        sidebar = bslib::sidebar("Right sidebar",
          position = "right", open = FALSE),
        "Main contents",
        border = FALSE
      ),
      border_radius = FALSE,
      fillable = TRUE,
      class = "p-0"
    )
  )
}

server <- function(input, output, session) {

}

shiny::shinyApp(ui = ui, server = server)
