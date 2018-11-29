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

## ------------------------------------------------------------------------
posterior_filesname <- tempfile("out.RDa")
raket::create_posterior_files(
  input_filename = input_filename,
  posterior_filesname = posterior_filesname,
  verbose = TRUE
)

## ------------------------------------------------------------------------
print(readRDS(posterior_filesname))

## ------------------------------------------------------------------------
nltts_filename <- tempfile("nltt.RDa")
raket::create_nltt_file(
  input_filename = posterior_filesname,
  posterior_filesname = nltts_filename,
  burn_in_fraction = 0.4
)

## ------------------------------------------------------------------------
print(names(readRDS(nltts_filename)))

## ----fig.width=7, fig.height=7-------------------------------------------
ggplot2::ggplot(
  data = data.frame(nltts = readRDS(nltts_filename)$nltts),
  ggplot2::aes(x = nltts)
) + 
  ggplot2::geom_histogram(binwidth = 0.01) + 
  ggplot2::geom_density()

## ------------------------------------------------------------------------
csv_filename <- tempfile("nltts.csv")
raket::nltt_files_to_csv(
  nltt_filenames = nltts_filename, 
  csv_filename = csv_filename
)

## ------------------------------------------------------------------------
knitr::kable(read.csv(file = csv_filename))

## ------------------------------------------------------------------------
df <- raket::to_long(df = read.csv(csv_filename))

## ------------------------------------------------------------------------
knitr::kable(df)

## ----fig.width=7, fig.height=7-------------------------------------------
raket::create_fig_1(df_long = df)

