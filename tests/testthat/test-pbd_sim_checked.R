context("pbd_sim_checked")

# No need to check by raket, as
# this function moved to the PBD package

test_that("use", {

  expect_silent(
    pbd_sim_checked(
      erg = 0.0,
      eri = 0.0,
      scr = 1.0,
      sirg = 1.0,
      siri = 1.0,
      crown_age = 1.0
    )
  )
})
