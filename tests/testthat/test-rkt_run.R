context("rkt_run")

test_that("use, random", {

  skip("To be done")

  if (!beastier::is_on_travis()) return()

  raket_params <- create_test_raket_params()
  out <- rkt_run(raket_params = raket_params)
  expect_true("parameters" %in% names(out))
  expect_true("incipient_tree" %in% names(out))
  expect_true("species_tree" %in% names(out))
  expect_true("alignment" %in% names(out))
  expect_true("trees" %in% names(out))
  expect_true("estimates" %in% names(out))
})

test_that("use, random", {

  skip("To be done")

  if (!beastier::is_on_travis()) return()

  raket_params <- create_test_raket_params()

  for (sampling_method in rkt_get_sampling_methods()) {
    raket_params$sampling_method <- sampling_method
    out <- rkt_run(raket_params = raket_params)
    expect_true("parameters" %in% names(out))
    expect_true("incipient_tree" %in% names(out))
    expect_true("species_tree" %in% names(out))
    expect_true("alignment" %in% names(out))
    expect_true("trees" %in% names(out))
    expect_true("estimates" %in% names(out))
  }
})
