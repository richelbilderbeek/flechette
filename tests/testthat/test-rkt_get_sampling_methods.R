context("rkt_get_sampling_methods")

test_that("use", {
  expect_true("random" %in% rkt_get_sampling_methods())
  expect_true("shortest" %in% rkt_get_sampling_methods())
  expect_true("longest" %in% rkt_get_sampling_methods())
})
