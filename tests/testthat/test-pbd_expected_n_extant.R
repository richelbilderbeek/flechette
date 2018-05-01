context("pbd_expected_n_extant")

test_that("minimal use", {
  
  testthat::expect_silent(
    pbd_expected_n_extant(
      crown_age = 1.0,
      scr = 1.0,
      sirg = 1.0,
      siri = 1.0,
      erg = 0.0,
      eri = 0.0
    )
  )
})

test_that("bigger crown age results in more lineages", {

  scr <- 1.0
  sirg <- 1.0
  siri <- 1.0
  erg <- 0.0
  eri <- 0.0

  n_lineages_young <- pbd_expected_n_extant(
    crown_age = 1.0,
    scr = scr,
    sirg = sirg,
    siri = siri,
    erg = erg,
    eri = eri
  )

  n_lineages_old <- pbd_expected_n_extant(
    crown_age = 2.0,
    scr = scr,
    sirg = sirg,
    siri = siri,
    erg = erg,
    eri = eri
  )
  testthat::expect_lt(n_lineages_young,n_lineages_old)

})

test_that("less extinction results in more lineages", {

  # For students?
  
})

test_that("more speciation initiation results in more lineages", {

  # For students?
  
})

test_that("more speciation completion results in more lineages", {

  # For students?
  
})

test_that("abuse", {

  testthat::expect_error(
    pbd_expected_n_extant(
      crown_age = -123456, # Error
      scr = 1.0,
      sirg = 1.0,
      siri = 1.0,
      erg = 0.0,
      eri = 0.0
    ),
    "'crown age' must be non-zero and positive"
  )

  # More error checking for students?
  
})
