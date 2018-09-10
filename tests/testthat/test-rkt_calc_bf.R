context("rkt_calc_bf")

pos_jc69_logliks <- c(
  -6858.78167488839,
  -6858.36454566168,
  -6863.98682058714,
  -6857.51507713761,
  -6858.70972433526,
  -6857.85617988166,
  -6860.38718168892,
  -6858.79990748872,
  -6863.56514356465
)

pos_gtr_logliks <- c(
  -6857.75748158935,
  -6861.14469615718,
  -6860.02524225839,
  -6856.33413124524,
  -6856.32193970325,
  -6859.68426715223,
  -6860.04737674122,
  -6858.10883653564,
  -6857.74819532999
)

test_that("use RJCB", {
  # For the same data, BF should be one
  expect_equal(1.0, rkt_calc_bf(pos_jc69_logliks, pos_jc69_logliks))
  expect_equal(1.0, rkt_calc_bf(pos_gtr_logliks, pos_gtr_logliks))
})

test_that("use RSE", {
  # For the same data, BF should be one
  expect_silent(rkt_calc_bf_rse(pos_jc69_logliks, pos_jc69_logliks))
  expect_silent(rkt_calc_bf_rse(pos_gtr_logliks, pos_gtr_logliks))
})
