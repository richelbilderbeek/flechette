## ----setup, include = FALSE----------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----load_library--------------------------------------------------------
library(raket)

## ----set_folder_name-----------------------------------------------------
folder_name <- tempdir()

## ----set_seed------------------------------------------------------------
set.seed(42)

## ------------------------------------------------------------------------
all_input_filenames <- create_input_files_general(
  general_params_set = create_general_params_set(
    mcmc_chain_length = 16000,
    sequence_length = 16
  ),
  folder_name = folder_name
)

## ------------------------------------------------------------------------
while (1) {
  input_filename <- sample(all_input_filenames, size = 1)
  lowest_sir <- min(rkt_get_spec_init_rates())
  if (readRDS(input_filename)$sirg > lowest_sir) next
  if (readRDS(input_filename)$siri > lowest_sir) next
  break
}
statuses <- file.remove(all_input_filenames[ all_input_filenames != input_filename] )
testit::assert(all(statuses == TRUE))
testit::assert(file.exists(input_filename))

## ------------------------------------------------------------------------
print(readRDS(input_filename))

