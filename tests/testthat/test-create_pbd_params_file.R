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

  #
  # From here: same tests as used in 'collect_pbd_params':
  #
  df <- read.csv(file = filename)


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

  skip("WIP")

  expect_error(
    create_pbd_params_file(project_folder_name = "nonsense"),
    "'project_folder_name' must end with 'raket_werper'"
  )
})
