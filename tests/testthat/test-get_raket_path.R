context("test-get_raket_path")

test_that("use", {

  expect_silent(get_raket_path("parameters.RDa"))

  expect_equal(
    system.file("extdata", "parameters.RDa", package = "raket"),
    get_raket_path("parameters.RDa")
  )
})

test_that("abuse", {

  expect_error(
    get_raket_path("abs.ent"),
    "'filename' must be the name of a file in 'inst/extdata'"
  )
})
