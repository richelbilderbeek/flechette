context("rkt_plot")

test_that("use", {

  skip("WIP richelbilderbeek")
  n_replicates <- rkt_get_n_replicates()
  n_nltts <- 1000

  if (!ribir::is_on_travis()) {
    # Smaller on local computer
    n_replicates <- 4
    n_nltts <- 10
  }

  n_rows <- n_replicates * rkt_get_n_param_combos()
  testit::assert(n_rows <= rkt_get_max_n_rows())
  testit::assert(rkt_get_n_params() + 1 + n_nltts <= rkt_get_max_n_cols())

  for (experiment_type in rkt_get_experiment_types()) {

    experiment_type <- "sampling"
    # Create a fake data frame
    df <- rkt_create_data_frame(
      n_replicates = n_replicates,
      n_nltts = n_nltts,
      experiment_type = experiment_type
    )
    #if (experiment_type == "general") next # nolint WIP
    if (experiment_type == "sampling") next # nolint WIP
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
    # file.copy(filename, paste0("~/", experiment_type, ".pdf")) # nolint WIP
  }
})
