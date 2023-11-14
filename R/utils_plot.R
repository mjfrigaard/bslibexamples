#' Histogram custom function
#'
#' @param df dataset
#' @param x_var x variable
#' @param bins_var bins (numeric)
#'
#' @return ggplot2 plot
#'
#' @export
#'
#' @importFrom rlang .data
#'
hist_plot <- function(df, x_var, bins_var) {
    ggplot2::ggplot(data = df,
      ggplot2::aes(x = .data[[x_var]])) +
      ggplot2::geom_histogram(bins = bins_var) +
      ggplot2::theme_bw(base_size = 20)

}
