#' Plot violin plot
#' @param df_long data frame in the long form
#' @export
plot <- function(
  df_long
) {
  # Satsfy R CMD check
  speciation_completion_rate <- NULL
  sampling_method <- NULL
  extinction_rate <- NULL
  speciation_initiation_rate <- NULL
  nltt <- NULL
  
  ggplot2::ggplot(
    data = df_long,
    ggplot2::aes(
      x = as.factor(scr),
      y = nltt,
      fill = sampling_method
    )
  ) + ggplot2::geom_violin() +
    ggplot2::facet_grid(
      erg ~ sirg,
      drop = FALSE
    )
}
