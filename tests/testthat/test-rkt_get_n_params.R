context("rkt_get_n_params")

test_that("rkt_get_n_params must match the number of parameter", {
  raket_params <- create_test_raket_params()

  expect_equal(rkt_get_n_params(), length(unlist(raket_params)))
})
