context("test-check_project_folder_name")

test_that("use", {

  expect_error(
    check_project_folder_name(
      project_folder_name = "nonsense"
    ),
    "'project_folder_name' must end with 'raket_werper'"
  )

  expect_error(
    check_project_folder_name(
      project_folder_name = "absent/raket_werper"
    ),
    "'project_folder_name' absent"
  )

})
