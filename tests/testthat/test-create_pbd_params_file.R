test_that("use", {

  skip("WIP")

  # Should create 'results/'pbd_params.csv'
  filename <- create_pbd_params_file(
    project_folder_name = get_raket_path("raket_werper")
  )

  # File should be created
  expect_true(file.exists(filename))

  # OK: filename must end with 'pbd_params.csv'
  expect_true(
    length(
      grep(
        pattern = "pbd_params\\.csv$", filename, perl = TRUE, value = TRUE
      )
    ) > 0
  )
  # OK: should be in raket_werper/results folder
  # Use ..? to indicate one or two back- or normal slashes
  expect_true(
    length(
      grep(
        pattern = "raket_werper..?results..?",
        filename, perl = TRUE, value = TRUE
      )
    ) > 0
  )
})

test_that("abuse", {

  expect_error(
    create_pbd_params_file(project_folder_name = "nonsense"),
    "'project_folder_name' must end with 'raket_werper'"
  )
})
