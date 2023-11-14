library(bslib)
library(shiny)
library(crosstalk)
library(plotly)
library(leaflet)
library(bsicons)

# Creates the "filter link" between the controls and plots
dat <- SharedData$new(dplyr::sample_n(diamonds, 1000))

# Sidebar elements (e.g., filter controls)
filters <- list(
  crosstalk::filter_select(
    id = "cut",
    label = "Cut",
    sharedData = dat,
    group = ~ cut
  ),
  crosstalk::filter_select(
    id = "color",
    label = "Color",
    sharedData = dat,
    group = ~ color
  ),
  crosstalk::filter_select(
    id = "clarity",
    label = "Clarity",
    sharedData = dat,
    group = ~ clarity
  )
)

# plotly visuals
plots <- list(
  plotly::plot_ly(dat) |> plotly::add_histogram(x = ~price),
  plotly::plot_ly(dat) |> plotly::add_histogram(x = ~carat),
  plotly::plot_ly(dat) |> plotly::add_histogram(x = ~cut, color = ~clarity)
)
plots <- lapply(plots, \(x) plotly::config(p = x, displayModeBar = FALSE))

# map filter and visual
quake_dat <- SharedData$new(quakes)
map_filter <-
  crosstalk::filter_slider(
    id = "mag",
    label = "Magnitude",
    sharedData = quake_dat,
    column = ~ mag
  )
map_quakes <- leaflet::leaflet(quake_dat) |>
  leaflet::addTiles() |>
  leaflet::addCircleMarkers()
