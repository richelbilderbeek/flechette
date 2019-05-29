context("create_raket_params")

test_that("use", {

  pbd_params <- becosys::create_pbd_params(
    sirg = 0.1,
    siri = 0.15,
    scr = 0.2,
    erg = 0.01,
    eri = 0.02
  )
  pir_params <- pirouette::create_test_pir_params()
  sampling_method <- "shortest"

  raket_params <- create_raket_params(
    pbd_params = pbd_params,
    pir_params = pir_params,
    sampling_method = sampling_method
  )

  expect_equal(pbd_params, raket_params$pbd_params)
  expect_equal(pir_params, raket_params$pir_params)
  expect_equal(sampling_method, as.character(raket_params$sampling_method))
})
