ui <- function() {
  bslib::page_navbar(
    title = "Conditional sidebar with inputs",
    id = "nav",
    sidebar = bslib::sidebar(
      # see nav_panel("Page 1")
      conditionalPanel(
        condition = "input.nav === 'info'",
        "sidebar (no inputs, no values)"
      ),
      # see nav_panel("numeric inputs") ----
      conditionalPanel(
        condition = "input.nav === 'numeric inputs'",
        strong(code("numeric module inputs")),
        mod_numeric_inputs_ui("sb_01"),
        strong(code("reactive value outputs")),
        verbatimTextOutput("vals01")
      ),
      # see nav_panel("text inputs")
      conditionalPanel(
        condition = "input.nav === 'text inputs'",
        strong(code("text module inputs")),
        mod_text_inputs_ui("sb_02")
      )
    ),
    bslib::nav_panel(title = "info",
      "Page 1 (no inputs, no values)",
    ),
    # see conditionalPanel("input.nav === 'numeric inputs'") ----
    bslib::nav_panel(title = "numeric inputs",
      code("input.nav === 'numeric inputs'"),
      mod_numeric_inputs_ui("np_01")
    ),
    # see conditionalPanel("input.nav === 'text inputs'") ----
    bslib::nav_panel(title = "text inputs",
      code("input.nav === 'text inputs'"),
      strong(code("text module inputs")),
      mod_text_inputs_ui("np_02"),
      strong(code("text reactive value outputs")),
      verbatimTextOutput("vals02")
    ),
    bslib::nav_panel(title = "all inputs",
      strong("All text and numeric inputs and reactive values from",
        code("rVals$all_vals()")),
      verbatimTextOutput("vals03")
    )
  )
}

server <- function(input, output, session) {

  rVals <- shiny::reactiveValues()
  rVals$all_vals <- shiny::reactive({
    shiny::reactiveValuesToList(input, all.names = TRUE)
  })


  mod_numeric_inputs_server("sb_01", .dev = TRUE)

  mod_text_inputs_server("sb_02", .dev = TRUE)

  mod_numeric_inputs_server("np_01", .dev = TRUE)

  mod_text_inputs_server("np_02", .dev = TRUE)

  shiny::observe({
    if (rVals$all_vals()$nav == "numeric inputs") {
      output$vals01 <- shiny::renderPrint({
        inputs_01 <- grep("sb_01|np_01", names(rVals$all_vals()),
                         value = TRUE)
        rVals$all_vals()[inputs_01]
      })
    } else if (rVals$all_vals()$nav == "text inputs") {
      output$vals02 <- shiny::renderPrint({
        inputs_02 <- grep("np_02|sb_02", names(rVals$all_vals()),
                         value = TRUE)
        rVals$all_vals()[inputs_02]
      })
    } else {
      output$vals03 <- shiny::renderPrint({
        rVals$all_vals()
      })
    }
  })

  output$vals <- shiny::renderPrint({
    rVals$all_vals()
  })

}

shiny::shinyApp(ui = ui, server = server)
