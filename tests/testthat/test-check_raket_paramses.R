test_that("use", {


  expect_silent(
    check_raket_paramses(
      list(create_test_raket_params())
    )
  )
  expect_silent(
    check_raket_paramses(
      create_general_params_set(max_n_params = 2)
    )
  )
  expect_error(
    check_raket_paramses(
      create_test_raket_params()
    ),
    "'raket_paramses' must be a list of 'raket_params'"
  )
  expect_error(
    check_raket_paramses(
      "nonsense"
    ),
    "'raket_paramses' must be a list"
  )
})
