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
