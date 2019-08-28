test_that("use", {

  df <- collect_pbd_params(
    project_folder_name = get_raket_path("raket_werper")
  )

  # Use relative folder path as the primary key
  #
  # E.g. an experiment with its parameter file at either of these locations
  #
  #   /home/richel/razzo_project/data/1/2/3/parameters.RDa
  #   C:\Giappo\razzo_project\data\1\2\3\parameters.RDa
  #
  # would get
  #
  #  data/1/2/3                                                                 # nolint this is not commented code
  #
  expect_true("folder" %in% names(df))

  # The measurements, simply all arguments of 'create_params_mbd'
  expect_true("erg" %in% names(df))
  expect_true("eri" %in% names(df))
  expect_true("scr" %in% names(df))
  expect_true("sirg" %in% names(df))
  expect_true("siri" %in% names(df))

  # Data must make sense
  expect_true(all(df$erg >= 0.0))
  expect_true(all(df$eri >= 0.0))
  expect_true(all(df$scr >= 0.0))
  expect_true(all(df$sirg >= 0.0))
  expect_true(all(df$siri >= 0.0))
})

test_that("abuse", {

  expect_error(
    collect_pbd_params(
      project_folder_name = "nonsense"
    ),
    "'project_folder_name' must end with 'raket_werper'"
  )
})
