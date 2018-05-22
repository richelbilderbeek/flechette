#' Plot violin plot
#' @param df_long data frame in the long form
#' @param pdf_filename name of the PDF with the plot
#' @export
rkt_plot <- function(
  df_long = utils::read.csv("result_long.csv"),
  pdf_filename = tempfile(fileext = ".pdf")
) {
  # Satsfy R CMD check
  scr <- NULL; rm(scr) # nolint, fixes warning: no visible binding for global variable
  sampling_method <- NULL; rm(sampling_method) # nolint, fixes warning: no visible binding for global variable
  erg <- NULL; rm(erg) # nolint, fixes warning: no visible binding for global variable
  sirg <- NULL; rm(sirg) # nolint, fixes warning: no visible binding for global variable
  nltt <- NULL; rm(nltt) # nolint, fixes warning: no visible binding for global variable
  if (all(df_long$sampling_method == "random")) {
    # The general dataset
    ggplot2::ggplot(
      data = df_long,
      ggplot2::aes(
        x = as.factor(scr),
        y = nltt
      )
    ) +
      ggplot2::geom_violin() +
      ggplot2::facet_grid(
        erg ~ sirg,
        drop = FALSE
      ) +
      ggplot2::ggtitle("The general data set")
  } else {
    # Measure the effect of sampling
    ggplot2::ggplot(
      data = df_long,
      ggplot2::aes(
        x = as.factor(scr),
        y = nltt,
        fill = sampling_method
      )
    ) +
      ggplot2::geom_violin() +
      ggplot2::facet_grid(
        erg ~ sirg,
        drop = FALSE
      ) +
      ggplot2::ggtitle("The effect of sampling")
  }
  ggplot2::ggsave(
    filename = pdf_filename,
    device = "pdf",
    width = 21,
    height = 29.7,
    units = "cm"
  )
}
