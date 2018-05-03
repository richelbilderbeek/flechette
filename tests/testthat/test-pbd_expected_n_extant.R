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
  testthat::expect_lt(n_lineages_young, n_lineages_old)

})

test_that("less extinction results in more lineages", {

  crown_age <- 2.0
  scr <- 1.0
  sirg <- 1.0
  siri <- 1.0
  
  n_lineages_more <- pbd_expected_n_extant(
    crown_age = crown_age,
    scr = scr,
    sirg = sirg,
    siri = siri,
    erg = 3.0,
    eri = 3.0
  )
  
  n_lineages_less <- pbd_expected_n_extant(
    crown_age = crown_age,
    scr = scr,
    sirg = sirg,
    siri = siri,
    erg = 1.0,
    eri = 1.0
  )
  
  testthat::expect_more_than(n_lineages_less, n_lineages_more)

})

test_that("more speciation initiation results in more lineages", {

  crown_age <- 1.0
  scr <- 1.0
  erg <- 0.0
  eri <- 0.0
  
  n_lineages_more <- pbd_expected_n_extant(
    crown_age = crown_age,
    scr = scr,
    sirg = 2.0,
    siri = 2.0,
    erg = erg,
    eri = eri
  )
  
  n_lineages_less <- pbd_expected_n_extant(
    crown_age = crown_age,
    scr = scr,
    sirg = 1.0,
    siri = 1.0,
    erg = erg,
    eri = eri
  )
  testthat::expect_lt(n_lineages_less, n_lineages_more)

})

test_that("more speciation completion results in more lineages", {

  crown_age <- 1.0
  sirg <- 1.0
  siri <- 1.0
  erg <- 0.0
  eri <- 0.0
  
  n_lineages_less <- pbd_expected_n_extant(
    crown_age = crown_age,
    scr = 1.0,
    sirg = sirg,
    siri = siri,
    erg = erg,
    eri = eri
  )
  
  n_lineages_more <- pbd_expected_n_extant(
    crown_age = crown_age,
    scr = 3.0,
    sirg = sirg,
    siri = siri,
    erg = erg,
    eri = eri
  )
  testthat::expect_lt(n_lineages_less, n_lineages_more)

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
