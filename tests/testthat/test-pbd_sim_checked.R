context("pbd_sim_checked")

test_that("use", {

  skip("TODO for @J-Damhuis and @Tomdkkr")

  expect_silent(
    pbd_sim_checked(
      ... # TODO
    )
  )
})

test_that("PBD::pbd_sim and pbd_sim_checked must give same results", {

  skip("TODO for @J-Damhuis and @Tomdkkr")

  # This will be harder!
  # You will have to duck to compare elements of lists

  expect_equal(
    pbd_sim_checked(
      ... # TODO
    ),
    PBD::pbd_sim(
      ... # TODO
    )
  )
})

test_that("abuse", {

  skip("TODO for @J-Damhuis and @Tomdkkr")

  expect_error(
    pbd_sim_checked(
      ..., # TODO
      erg = -123
    ),
    "'erg' must be positive"
  )

  expect_error(
    pbd_sim_checked(
      ..., # TODO
      eri = -123
    ),
    "'eri' must be positive"
  )

  expect_error(
    pbd_sim_checked(
      ..., # TODO
      scr = -123
    ),
    "'scr' must be positive"
  )

  expect_error(
    pbd_sim_checked(
      ..., # TODO
      sirg = -123
    ),
    "'sirg' must be non-zero and positive"
  )

  expect_error(
    pbd_sim_checked(
      ..., # TODO
      siri = -123
    ),
    "'siri' must be non-zero and positive"
  )

  expect_error(
    pbd_sim_checked(
      ..., # TODO
      crown_age = NULL,
      stem_age = NULL
    ),
    "At least one of 'crown_age' or 'stem_age' must be non-zero and positive"
  )

  expect_error(
    pbd_sim_checked(
      ..., # TODO
      crown_age = -123,
      stem_age = NULL
    ),
    "'crown_age' must be non-zero and positive"
  )

  expect_error(
    pbd_sim_checked(
      ..., # TODO
      crown_age = NULL,
      stem_age = -123
    ),
    "'stem_age' must be non-zero and positive"
  )

  expect_error(
    pbd_sim_checked(
      ..., # TODO
      crown_age = 123,
      stem_age = 234
    ),
    "Must set either 'crown_age' or 'stem_age'"
  )

})
