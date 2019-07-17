context("test-check_raket_params")

test_that("use", {

  good_raket_params <- create_test_raket_params()
  expect_silent(
    check_raket_params(raket_params = good_raket_params)
  )

  pbd_params <- create_test_pbd_params()
  pir_params <- peregrine::create_test_pff_pir_params(
    twinning_params = peregrine::create_pff_twinning_params()
  )
  sampling_method <- rkt_get_sampling_methods()[3]

  expect_silent(
    create_raket_params(
      pbd_params = pbd_params,
      pir_params = pir_params,
      sampling_method = sampling_method
    )
  )

  # Check elements
  expect_error(
    check_raket_params(raket_params = list()),
    "'pbd_params' must be an element of a 'raket_params'"
  )

  expect_error(
    check_raket_params(raket_params = list(pbd_params = pbd_params)),
    "'pir_params' must be an element of a 'raket_params'"
  )

  expect_error(
    check_raket_params(raket_params = list(
      pbd_params = pbd_params, pir_params = pir_params)
    ),
    "'sampling_method' must be an element of a 'raket_params'"
  )

  # Check pbd_params
  # done by check_pbd_params

  # Check pir_params
  # Done by pirouette::check_pir_params and peregrine::check_pff_pir_params
})
