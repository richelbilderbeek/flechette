## ----setup, include = FALSE----------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ------------------------------------------------------------------------
library(pirouette)
library(mbd)

## ------------------------------------------------------------------------
extinction_rate <- 0.1

## ------------------------------------------------------------------------
true_tree <- ape::read.tree(text = "((A:12, B:12):3, (C:12, D:12):3);")
#babette::plot_densitree(c(true_tree))

## ------------------------------------------------------------------------
ml_est <- mbd::mbd_calc_max_lik(
  branching_times = ape::branching.times(true_tree),
  init_param_values = mbd::create_mbd_params(
    lambda = 0.1, 
    mu = extinction_rate, 
    nu = 0.0, 
    q = 0.0
  ),
  fixed_params = mbd::create_mbd_params_selector(mu = TRUE, nu = TRUE, q = TRUE),
  estimated_params = mbd::create_mbd_params_selector(lambda = TRUE),
  init_n_species = 2
)
ml_est

