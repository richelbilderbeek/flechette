# raket pipeline

All these command must be done when logged in on Peregrine.

First install `raket`, its dependencies, and BEAST2:

```
sbatch install_raket
```

This will fail with error `no permission to install to directory apps/haswell/software/R`.
To fix this, do:

```
module load R
R
install.packages("stringr")
# Say yes, yes, pick mirror
q()
```

```
sbatch install_raket
```

When this is done, create the parameter files:

```
# Use one of these two:
sbatch create_input_files_general
sbatch create_input_files_sampling # Does not work yet
```

The parameter files will be created locally and have names `1.RDa` to approx `9999.RDa`.
For doing only a subset of the experiment, delete irrelevant parameter files.

To start the main experiment (and most time consuming step):

```
sbatch create_output_files
```

The output files will be created locally and have names `out_1.RDa` to approx `out_9999.RDa`.

To extract the nLTT statistics:

```
sbatch create_nltt_files
```

The output files will be created locally and have names `nltt_1.RDa` to approx `nltt_9999.RDa`.

To convert all nLTT files to comma-seperated files:

```
sbatch nltt_files_to_csv
```

This will result in a file named `result.csv`



## Overview

Step|Function|Description
---|---|---
0|`install_raket`|Install `raket`, its dependencies, and BEAST2
1.1|`create_input_files_general`|Create all `.RDa` input/parameter files to do a general mapping
1.2|`create_input_files_sampling`|Create all `.RDa` input/parameter files to investigate the effect of sampling
2|`create_output_files`|Run all simulations
2.1|`create_output_file`|Run one simulation, store all info (such as all posterior phylogenies) as `.RDa`
3|`create_nltt_files`|Extract nLTT values from all output files
3.1|`create_nltt_file`|Extract nLTT values from one output file, store parameters and nLTTs as `.RDa`
4|`nltt_files_to_csv`|Merge all nLTT values into one `.csv` file
5|`to_long`|After reading the `.csv` with `read.csv()`, convert data frame to tidy data in the long form
6|`rkt_plot`|Plot the tidy data in long form as a violin plot, depends on sampling method


