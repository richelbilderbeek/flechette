context("rkt_plot")

test_that("use", {

  n_files <- rkt_get_n_replicates() * rkt_get_n_param_combos()
  n_nltts <- 1000

  if (!ribir::is_on_travis()) {
    # Smaller on local computer
    n_files <- 1 * rkt_get_n_param_combos()
    n_nltts <- 10
  }

  testit::assert(n_files <= rkt_get_max_n_rows())
  testit::assert(rkt_get_n_params() + 1 + n_nltts <= rkt_get_max_n_cols())

  for (experiment_type in rkt_get_experiment_types()) {

    # Create a fake data frame
    df <- rkt_create_data_frame(
      n_files = n_files,
      n_nltts = n_nltts,
      experiment_type = experiment_type
    )
    df_long <- to_long(df)

    rm(df)
    gc()
    
    filename <- tempfile(fileext = ".pdf")
    ggplot2::ggsave(
      filename = filename,
      plot = rkt_plot(df_long),
      device = "pdf",
      width = 21,
      height = 29.7,
      units = "cm"
    )

    rm(df_long)
    gc()

    testthat::expect_true(file.exists(filename))
    file.copy(
      filename, 
      paste0("~/", experiment_type, ".pdf")
    )
  }
})
