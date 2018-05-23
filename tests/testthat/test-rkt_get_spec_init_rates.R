context("rkt_get_spec_init_rates")

test_that("use", {
  expect_true(
    all(rkt_get_spec_init_rates() > 0.0)
  )
  # Used in Etienne et al., 2014
  expect_true(0.5 %in% rkt_get_spec_init_rates())
})
