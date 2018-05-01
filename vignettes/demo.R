## ----setup, include = FALSE----------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ------------------------------------------------------------------------
library(raket)
library(ggplot2)

## ------------------------------------------------------------------------
folder_name <- tempdir()

## ------------------------------------------------------------------------
set.seed(42)

## ------------------------------------------------------------------------
all_input_filenames <- raket::create_input_files_general(
  general_params_set = create_general_params_set(
    mcmc = beautier::create_mcmc(chain_length = 4000, store_every = 1000),
    sequence_length = 15
  ),
  folder_name = folder_name
)

## ------------------------------------------------------------------------
while (1) {
  input_filename <- sample(all_input_filenames, size = 1)
  if (readRDS(input_filename)$sirg > 0.1) next
  if (readRDS(input_filename)$siri > 0.1) next
  break
}
file.remove(all_input_filenames[ all_input_filenames != input_filename] )
testit::assert(file.exists(input_filename))

## ------------------------------------------------------------------------
print(readRDS(input_filename))

