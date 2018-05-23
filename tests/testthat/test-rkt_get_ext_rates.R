context("rkt_get_ext_rates")

test_that("use", {

  expect_true(all(rkt_get_ext_rates() >= 0.0))

  # Same extinction rates as in Etienne et al., 2014
  expect_true(0.0 %in% rkt_get_ext_rates())
  expect_true(0.1 %in% rkt_get_ext_rates())
  expect_true(0.2 %in% rkt_get_ext_rates())
})
