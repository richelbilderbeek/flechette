## ----setup, include = FALSE----------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ------------------------------------------------------------------------
library(raket)

## ------------------------------------------------------------------------
folder_name <- tempdir()

## ------------------------------------------------------------------------
set.seed(42)

## ------------------------------------------------------------------------
all_input_filenames <- raket::create_input_files_general(
  general_params_set = raket::create_general_params_set(
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

## ------------------------------------------------------------------------
output_filename <- tempfile("out.RDa")
raket::create_output_file(
  input_filename = input_filename,
  output_filename = output_filename
)

## ------------------------------------------------------------------------
print(readRDS(output_filename))

## ------------------------------------------------------------------------
nltts_filename <- tempfile("nltt.RDa")
raket::create_nltt_file(
  input_filename = output_filename,
  output_filename = nltts_filename,
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
raket::rkt_plot(df_long = df)

