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

test_that("Ten percent of burn-in results in 1000 values, #10", {

  testthat::expect_equal(
    1000,
    length(
      tracerer::remove_burn_in(
        trace = seq(1, 1111),
        burn_in_fraction = 0.1
      )
    )
  )
})

test_that("Sequential RNG seeds are independent", {

  skip("Skip all tests")
  # Yes, they are
  return()

  # If a random number if drawn with one seed,
  # how long until it is drawn by differerently seeded
  # RNG?
  set.seed(2)
  value <- runif(n = 1)
  set.seed(1)
  i <- 0
  while (value != runif(n = 1)) {
    i <- i + 1
  }
  print(i)
})
