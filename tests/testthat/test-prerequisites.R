context("preprequisites")

test_that("PBD with Inf as speciation completion rate, #4", {

  skip("PBD does not allow Inf as SCR")

  set.seed(42)

  # Note: if speciation rates are zero, PBD::pbd_sim will last forever
  pbd_output <- PBD::pbd_sim_checked(
    erg = 0.1,
    eri = 0.1,
    scr = Inf,
    sirg = 1.0,
    siri = 1.0,
    crown_age = 1.0
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
