## ----setup, include = FALSE----------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ------------------------------------------------------------------------
set.seed(314)

## ------------------------------------------------------------------------
get_phylogeny_crown_age <- function(phylogeny) {
  n_taxa <- length(phylogeny$tip.label)
  ape::dist.nodes(phylogeny)[n_taxa + 1][1]
}
testit::assert(
  get_phylogeny_crown_age(ape::read.tree(text = "((A:1, B:1):1, C:2);")) == 2
)
testit::assert(
  get_phylogeny_crown_age(ape::read.tree(text = "((A:2, B:2):1, C:3);")) == 3
)
testit::assert(
  get_phylogeny_crown_age(ape::read.tree(text = "((A:2, B:2):2, C:4);")) == 4
)

## ------------------------------------------------------------------------
interpret_bayes_factor <- function(bayes_factor) {
  if (bayes_factor < 10^0.0) {
    "in favor of other model"
  } else if (bayes_factor < 10^0.5) {
    "barely worth mentioning"
  } else if (bayes_factor < 10^1.0) {
    "substantial"
  } else if (bayes_factor < 10^1.5) {
    "strong"
  } else if (bayes_factor < 10^2.0) {
    "very strong"
  } else {
    "decisive"
  }
}
testit::assert(interpret_bayes_factor(0.5) == "in favor of other model")
testit::assert(interpret_bayes_factor(1.5) == "barely worth mentioning")
testit::assert(interpret_bayes_factor(8.5) == "substantial")
testit::assert(interpret_bayes_factor(12.5) == "strong")
testit::assert(interpret_bayes_factor(85.0) == "very strong")
testit::assert(interpret_bayes_factor(123.0) == "decisive")

## ----fig.width=7---------------------------------------------------------
phylogeny <- ape::read.tree(text = "((((A:12, B:12):1,C:13):1,D:14):1, E:15);")
crown_age <- get_phylogeny_crown_age(phylogeny)
ape::plot.phylo(phylogeny)

## ----fig.width=7---------------------------------------------------------
sequence_length <- 1000

alignment_phydat <- phangorn::simSeq(
  phylogeny,
  l = sequence_length,
  rate = 1.0 / crown_age,
  rootseq = rep(c('a', 'c', 'g', 't'), each = sequence_length / 4)
)
testit::assert(class(alignment_phydat) == "phyDat")
alignment_dnabin <- ape::as.DNAbin(alignment_phydat)

fasta_filename <- tempfile(pattern = "bayes_factor_", fileext = ".fasta")
phangorn::write.phyDat(
  alignment_dnabin,
  file = fasta_filename,
  format = "fasta"
)
image(alignment_dnabin)

