context("preprequisites")

test_that("PBD with Inf as speciation completion rate, #4", {

  skip("PBD does not allow Inf as SCR")

  set.seed(42)
  pbd_parameters <- c(
    1.0, # speciation_initiation_rate
    Inf, # speciation_completion_rate
    1.0, # speciation_initiation_rate
    0.1, # extinction_rate
    0.1# extinction_rate
  )

  # Note: if speciation rates are zero, PBD::pbd_sim will last forever
  pbd_output <- PBD::pbd_sim(
    pbd_parameters,
    age = 1,
    soc = 2, # crown
    plotit = FALSE
  )

})

test_that("Can create such a big data frame, #9", {

  ncols <- 1050
  nrows <- 40000
  
  if (!ribir::is_on_travis()) {
    # Smaller on local computer
    ncols <- 105
    nrows <- 4000
  }
  ncells <- ncols*nrows
  
  testit::assert(ncells < 2^32-1)
  mem_use <- ncells * object.size(3.14)
  format(mem_use, units = "Mb")
  
  # Computer will freeze if you ignore this warning ..
  testit::assert(mem_use < ((2^32)-1))
  
  df <- data.frame(matrix(nrow = nrows, ncol = ncols, data = seq(1, ncells)))
  
  # Save and load should work
  filename <- tempfile()
  utils::write.csv(x = df, file = filename, row.names = FALSE)
  df2 <- read.csv(file = filename)
  testthat::expect_true(all.equal(df2, df, tolerance = 0.1))
  rm(df)
  rm(df2)
  # Manually call garbage collection, we need that memory directly
  gc()
})

test_that("Can convert a data frame to long form, #5", {

  skip("WIP")

})
