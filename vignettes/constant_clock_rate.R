## ----setup, include = FALSE----------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ------------------------------------------------------------------------
library(babette)
n_states <- 10
n_trees <- n_states * 0.8

## ------------------------------------------------------------------------
out_hard <- bbt_run(
  fasta_filenames = get_babette_path("anthus_aco.fas"),
  # fasta_filenames = get_babette_path("anthus_aco_sub.fas"),
  clock_models = create_strict_clock_model(),
  mcmc = create_mcmc(
    chain_length = n_states * 1000, 
    store_every = 1000
  )
)

## ------------------------------------------------------------------------
out_hard <- bbt_run(
  fasta_filenames = get_babette_path("anthus_aco.fas"),
  # fasta_filenames = get_babette_path("anthus_aco_sub.fas"),
  clock_models = create_strict_clock_model(
    clock_rate_param = create_clock_rate_param(
      value = 10.0, estimate = FALSE
    ),
    clock_rate_distr = create_normal_distr(
      mean = create_mean_param(
        value = 10.0, 
        estimate = FALSE
      ),
      sigma = create_sigma_param(
        value = 0.01, 
        estimate = FALSE
      )
    )
  ),
  mcmc = create_mcmc(
    chain_length = n_states * 1000, 
    store_every = 1000
  )
)

