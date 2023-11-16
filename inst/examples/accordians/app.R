# source("~/projects/pkgs/bslibexamples/inst/examples/04_accordians/global.R")

source("global.R")

ui <- function() {
accordion_filters <- bslib::accordion(
  bslib::accordion_panel(
    "Dropdowns",
    icon = bsicons::bs_icon("menu-app"),
    !!!filters
  ),
  bslib::accordion_panel(
    "Numerical",
    icon = bsicons::bs_icon("sliders"),
    crosstalk::filter_slider(id = "depth",
      label = "Depth",
      sharedData = dat, column = ~depth),
    crosstalk::filter_slider(id = "table",
      label = "Table",
      sharedData = dat, column = ~table)
  )
)

bslib::card(
  bslib::card_header("Groups of diamond filters"),
  bslib::layout_sidebar(
    sidebar = accordion_filters,
    plots[[1]]
  )
)
}

server <- function(input, output, session) {

}

shiny::shinyApp(ui = ui, server = server)

