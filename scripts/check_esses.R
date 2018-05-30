filenames <- list.files(pattern = "out_.*\\.RDa")

df <- data.frame(
  filename = rep(NA, length(filenames)),
  erg = rep(NA, length(filenames)),
  eri = rep(NA, length(filenames)),
  scr = rep(NA, length(filenames)),
  sirg = rep(NA, length(filenames)),
  siri = rep(NA, length(filenames)),
  n_taxa = rep(NA, length(filenames)),
  ess = rep(NA, length(filenames)),
  ok = rep(NA, length(filenames))
)  

row_index <- 1

for (filename in filenames) {
  file <- readRDS(filename)
  ess <- tracerer::calc_ess(
    trace = file$estimates$posterior, 
    sample_interval = 1000
  )
  ok <- ess > 200
  df$filename[row_index] <- filename
  df$erg[row_index] <- file$parameters$erg
  df$eri[row_index] <- file$parameters$eri
  df$scr[row_index] <- file$parameters$scr
  df$sirg[row_index] <- file$parameters$sirg
  df$siri[row_index] <- file$parameters$siri
  df$ess[row_index] <- ess
  df$n_taxa[row_index] <- ape::Ntip(file$incipient_tree)
  df$ok[row_index] <- ok
  row_index <- row_index + 1
}

min(df$ess)
# sum(!df$ok)
library(ggplot2)
ggplot(df, aes(ess, fill = ok)) + geom_histogram(binwidth = 10) + geom_vline(xintercept = 200) + ggtitle("ESSes of sampling parameter set")
ggplot(df[!df$ok, ], aes(siri, color = as.factor(sirg), fill = as.factor(scr))) + geom_histogram(binwidth = 0.1, size = 2) + ggtitle("Biological parameters of ESS less than 200")
ggplot(df, aes(n_taxa, fill = ok)) + geom_histogram(binwidth = 10) + ggtitle("Number of taxa and ESS")
