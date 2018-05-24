context("pbd_get_exp_n_lineages_pb")

test_that("use", {

  skip("Skip all tests")
  expect_output(
    pbd_get_exp_n_lineages_pb(
      sirg = 1.0,
      scr = 1.0,
      siri = 1.0,
      age = 1.0,
      ng = 1.0,
      ni = 0.0
    )
  )

  expect_output(
    pbd_get_exp_n_lineages_pb(
      sirg = 1.0,
      scr = 1.0,
      siri = 1.0,
      age = 1.0,
      ng = 0.0,
      ni = 1.0
    )
  )
})

test_that("abuse", {

  expect_error(
    pbd_get_exp_n_lineages_pb(
      sirg = -1.0,
      scr = 1.0,
      siri = 1.0,
      age = 1.0,
      ng = 0.0,
      ni = 1.0
    ),
    "'sirg' must be non-zero and positive"
  )

  expect_error(
    pbd_get_exp_n_lineages_pb(
      sirg = 1.0,
      scr = -1.0,
      siri = 1.0,
      age = 1.0,
      ng = 0.0,
      ni = 1.0
    ),
    "'scr' must be non-zero and positive"
  )

  expect_error(
    pbd_get_exp_n_lineages_pb(
      sirg = 1.0,
      scr = 1.0,
      siri = -1.0,
      age = 1.0,
      ng = 0.0,
      ni = 1.0
    ),
    "'siri' must be non-zero and positive"
  )

  expect_error(
    pbd_get_exp_n_lineages_pb(
      sirg = 1.0,
      scr = 1.0,
      siri = 1.0,
      age = -1.0,
      ng = 0.0,
      ni = 1.0
    ),
    "'age' must be non-zero and positive"
  )

   expect_error(
    pbd_get_exp_n_lineages_pb(
      sirg = 1.0,
      scr = 1.0,
      siri = 1.0,
      age = 1.0,
      ng = -1.0,
      ni = 0.0
    ),
    "'ng' must be zero or positive"
  )

   expect_error(
     pbd_get_exp_n_lineages_pb(
       sirg = 1.0,
       scr = 1.0,
       siri = 1.0,
       age = 1.0,
       ng = 0.0,
       ni = -1.0
     ),
     "'ni' must be zero or positive"
   )

   expect_error(
     pbd_get_exp_n_lineages_pb(
       sirg = 1.0,
       scr = 1.0,
       siri = 1.0,
       age = 1.0,
       ng = 1.0,
       ni = 1.0
     ),
     "Only one of 'ng' and 'ni' can be non-zero"
   )

   expect_error(
     pbd_get_exp_n_lineages_pb(
       sirg = 1.0,
       scr = 1.0,
       siri = 1.0,
       age = 1.0,
       ng = 0.0,
       ni = 0.0
     ),
     "One of 'ng' and 'ni' must be non-zero"
   )

   expect_error(
     pbd_get_exp_n_lineages_pb(
       sirg = 1.0,
       scr = 1.0,
       siri = 1.0,
       age = 1.0,
       ng = -1.0,
       ni = -1.0
     ),
     "'ng' must be zero or positive"
   )
})
