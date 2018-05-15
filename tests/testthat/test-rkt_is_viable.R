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
