test_that("use", {

  for (sampling_method in rkt_get_sampling_methods()) {
    expect_silent(check_sampling_method(sampling_method))
  }

  expect_error(
    check_sampling_method("nonsense"),
    "'sampling_method' must be a sampling method"
  )
  expect_error(
    check_sampling_method(c()),
    "'sampling_method' must be one sampling method"
  )
  expect_error(
    check_sampling_method(rkt_get_sampling_methods()),
    "'sampling_method' must be one sampling method"
  )
  expect_error(
    check_sampling_method(NULL),
    "'sampling_method' must be one sampling method"
  )
  expect_error(
    check_sampling_method(NA),
    "'sampling_method' must be a sampling method"
  )
})
