setwd("~/data/20180530")
filenames <- list.files(pattern = ".*\\.RDa")

df <- data.frame(
  filename = rep(NA, length(filenames)),
  sampling_interval = rep(NA, length(filenames))
)  

row_index <- 1


for (filename in filenames) {
  file <- readRDS(filename)
  df$filename[row_index] <- filename
  df$sampling_interval[row_index] <- file$mcmc$store_every
  row_index <- row_index + 1
}

max(df$sampling_interval)
# sum(!df$ok)
library(ggplot2)
ggplot(df, aes(as.factor(sampling_interval))) + geom_histogram(stat = "count") + ggtitle("Sampling intervals")

