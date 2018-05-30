
filenames <- list.files(pattern = "out_.*\\.RDa")

df <- data.frame(
  filename = rep(NA, length(filenames)),
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
  df$ess[row_index] <- ess
  df$ok[row_index] <- ok
  row_index <- row_index + 1
}

print(df)
# sum(!df$ok)
# ggplot(df, aes(ess, fill = ok)) + geom_histogram(binwidth = 10) + geom_vline(xintercept = 200) + ggtitle("ESSes of sampling parameter set")
