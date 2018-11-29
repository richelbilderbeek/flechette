## ----setup, include = FALSE----------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----load_library--------------------------------------------------------
library(raket)
if (!mauricer::mrc_is_installed("NS")) {
  mauricer::mrc_install("NS")
}

## ----set_project_folder_name---------------------------------------------
# Put files in temporary folder
super_folder_name <- tempdir()
project_folder_name <- file.path(super_folder_name, "raket_werper")
# Do not warn if the folder already exists
dir.create(path = project_folder_name, showWarnings = FALSE)

## ----set_seed------------------------------------------------------------
set.seed(42)

## ------------------------------------------------------------------------
all_input_filenames <- create_input_files_general(
  general_params_set = create_general_params_set(
    mcmc_chain_length = 16000,
    sequence_length = 16
  ),
  project_folder_name = project_folder_name
)

## ------------------------------------------------------------------------
while (1) {
  input_filename <- sample(all_input_filenames, size = 1)
  lowest_sir <- min(rkt_get_spec_init_rates())
  if (utils::read.csv(input_filename)$sirg > lowest_sir) next
  if (utils::read.csv(input_filename)$siri > lowest_sir) next
  break
}
statuses <- file.remove(all_input_filenames[ all_input_filenames != input_filename] )
testit::assert(all(statuses == TRUE))
testit::assert(file.exists(input_filename))

## ------------------------------------------------------------------------
print(utils::read.csv(input_filename))

