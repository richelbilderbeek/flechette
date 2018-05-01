#' Plot violin plot
#' @param df_long data frame in the long form
#' @export
plot <- function(
  df_long
) {
  # Satsfy R CMD check
  scr <- NULL; rm(scr) # nolint, fixes warning: no visible binding for global variable
  sampling_method <- NULL; rm(sampling_method) # nolint, fixes warning: no visible binding for global variable
  erg <- NULL; rm(erg) # nolint, fixes warning: no visible binding for global variable
  sirg <- NULL; rm(sirg) # nolint, fixes warning: no visible binding for global variable
  nltt <- NULL; rm(nltt) # nolint, fixes warning: no visible binding for global variable
  
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
