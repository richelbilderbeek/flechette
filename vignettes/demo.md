---
title: "raket demo"
author: "Richel J.C. Bilderbeek"
date: "2018-05-18"
output: rmarkdown::html_vignette
vignette: >
  %\VignetteIndexEntry{raket demo}
  %\VignetteEngine{knitr::rmarkdown}
  %\VignetteEncoding{UTF-8}
---



This vignette shows the full pipeline of one single experiment, starting 
from its parameters to plotting the final distribution of nLTT statistics.

As these experiments are intended to run on a computer cluster, each
step saves its result to a file. This is a bit cumbersome for a vignette,
but the best that can be done.

First we load the libraries we'll need:


```r
# Nothing
```

The research produces two data sets:

 * a general balanced data set
 * a data set conditioned on sampling having an effect

This vignette will run one experiment for the general data set.

For this data set, we will create all parameter files, after which we
will keep only one file to actually run. Additionally, we will create
parameters that are shorter to run.

First, we'll specify the folder in which the files are created. By default,
this is a temporary folder, but this can be changed for those that
want to see the files:


```r
folder_name <- tempdir()
```

To make this vignette as reproducible as possible,
a random number generator seed is specified:


```r
set.seed(42)
```

Create all parameter files:


```r
all_input_filenames <- raket::create_input_files_general(
  general_params_set = raket::create_general_params_set(
    mcmc = beautier::create_mcmc(chain_length = 4000, store_every = 1000),
    sequence_length = 15
  ),
  folder_name = folder_name
)
```

Note that the created files have some simplified parameters, 
so the simulations are faster to run.

Remove all parameter files, except for a randomly sampled one
with speciation initiation rate of 0.1:


```r
while (1) {
  input_filename <- sample(all_input_filenames, size = 1)
  if (readRDS(input_filename)$sirg > 0.1) next
  if (readRDS(input_filename)$siri > 0.1) next
  break
}
file.remove(all_input_filenames[ all_input_filenames != input_filename] )
#>  [1] TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE
#> [15] TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE
#> [29] TRUE TRUE TRUE TRUE TRUE TRUE TRUE
testit::assert(file.exists(input_filename))
```

The input file only contains parameters:


```r
print(readRDS(input_filename))
#> $sirg
#> [1] 0.1
#> 
#> $siri
#> [1] 0.1
#> 
#> $scr
#> [1] 1
#> 
#> $erg
#> [1] 0
#> 
#> $eri
#> [1] 0
#> 
#> $crown_age
#> [1] 15
#> 
#> $crown_age_sigma
#> [1] 5e-04
#> 
#> $sampling_method
#> [1] "random"
#> 
#> $mutation_rate
#> [1] 0.06666667
#> 
#> $sequence_length
#> [1] 15
#> 
#> $mcmc
#> $mcmc$chain_length
#> [1] 4000
#> 
#> $mcmc$store_every
#> [1] 1000
#> 
#> 
#> $tree_sim_rng_seed
#> [1] 3
#> 
#> $alignment_rng_seed
#> [1] 3
#> 
#> $beast2_rng_seed
#> [1] 3
```

The input file is then run, its results save to an output file:




















