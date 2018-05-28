context("rkt_get_site_models")

test_that("use", {
  expect_true("JC69" %in% rkt_get_site_models())
  expect_true("GTR" %in% rkt_get_site_models())
})
