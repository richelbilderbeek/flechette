context("rkt_get_max_n_rows")

test_that("Can create such a big data frame, #9", {

  skip("Really needed?")
  # Ideal
  ncols <- rkt_get_max_n_cols()
  nrows <- rkt_get_max_n_rows()

  if (!beastier::is_on_travis()) {
    # Smaller on local computer
    ncols <- ncols / 10
    nrows <- nrows / 10
  }
  ncells <- ncols * nrows

  testit::assert(ncells < 2 ^ 32 - 1)
  mem_use <- ncells * object.size(3.14)
  format(mem_use, units = "Mb")

  # Computer will freeze if you ignore this warning ..
  testit::assert(mem_use < 2 ^ 32 - 1)

  df <- data.frame(matrix(nrow = nrows, ncol = ncols, data = seq(1, ncells)))

  # Save and load should work
  filename <- tempfile()
  utils::write.csv(x = df, file = filename, row.names = FALSE)
  df2 <- utils::read.csv(file = filename)
  testthat::expect_true(all.equal(df2, df, tolerance = 0.1))
  rm(df)
  rm(df2)
  # Manually call garbage collection, we need that memory directly
  gc()
})
