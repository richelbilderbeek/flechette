filenames <- list.files(pattern = "out_.*\\.RDa")

print(paste("filename", "ess", "ok", sep = ","))

for (filename in filenames) {
  df <- readRDS(filename)
  ess <- tracerer::calc_ess(trace = df$estimates$posterior, sample_interval = 1000)
  ok <- ess > 200
  print(paste(filename, ess, ok, sep = ","))
}
