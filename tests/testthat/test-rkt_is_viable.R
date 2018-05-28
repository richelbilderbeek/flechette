context("rkt_is_viable")

test_that("use", {

  
  testthat::expect_true(
    rkt_is_viable(
      erg = 0.0,
      eri = 0.0,
      sirg = 0.1,
      siri = 0.1
    )
  )
  testthat::expect_false(
    rkt_is_viable(
      erg = 0.123, # More than sirg
      eri = 0.0,
      sirg = 0.1,
      siri = 0.1
    )
  )
  testthat::expect_false(
    rkt_is_viable(
      erg = 0.0,
      eri = 0.123, # More than siri
      sirg = 0.1,
      siri = 0.1
    )
  )
  testthat::expect_false(
    rkt_is_viable(
      erg = 0.0,
      eri = 0.0,
      sirg = 1.0, # Difference with erg too big
      siri = 0.1
    )
  )
  testthat::expect_false(
    rkt_is_viable(
      erg = 0.0,
      eri = 0.0,
      sirg = 0.1,
      siri = 1.0 # Difference with eri too big
    )
  )

})

test_that("use pbd_numspec_quantile", {

  skip("Must assume siri == sirg?")
  #' pbd_numspec_quantile(
  #'   pars = c(0.3, 0.1, 0.5, 0.1),
  #'   age = 10, soc = 2, quantile = 0.95
  #'  )
  PBD::pbd_numspec_quantile(
    pars = c(sir, erg, scr, eri)  
  )
})
