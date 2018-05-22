# raket pipeline

Step|Function|Description
---|---|---
0|`install_raket`|Install `raket`, its dependencies, and BEAST2
1.1|`create_input_files_general`|Create all `.RDa` input/parameter files to do a general mapping
1.2|`create_input_files_sampling`|Create all `.RDa` input/parameter files to investigate the effect of sampling
2|`create_output_file`|Run simulation, store all info (such as all posterior phylogenies) as `.RDa`
3|`create_nltt_files`|Extract nLTT values from output file, store parameters and nLTTs as `.RDa`
4|`nltt_files_to_csv`|Merge all nLTT values into one `.csv` file
5|`to_long`|After reading the `.csv` with `read.csv()`, convert data frame to tidy data in the long form
6|`rkt_plot`|Plot the tidy data in long form as a violin plot, depends on sampling method


```
sbatch install_raket
```