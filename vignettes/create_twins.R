## ----setup, include = FALSE----------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ------------------------------------------------------------------------
library(pirouette)

## ------------------------------------------------------------------------
extinction_rate <- 0.1

## ------------------------------------------------------------------------
true_tree <- ape::read.tree(text = "((A:12, B:12):3, (C:12, D:12):3);")
#babette::plot_densitree(c(true_tree))

## ------------------------------------------------------------------------
if (1 == 2) {
  ml_est <- becosys::mbd_calc_max_lik(
    branching_times = ape::branching.times(true_tree),
    init_param_values = becosys::create_mbd_params(
      lambda = 0.1, 
      mu = extinction_rate, 
      nu = 0.0, 
      q = 0.0
    ),
    fixed_params = becosys::create_mbd_params_selector(mu = TRUE, nu = TRUE, q = TRUE),
    opt_params = becosys::create_mbd_params_selector(lambda = TRUE),
    init_n_species = 2
  )
  ml_est
}

