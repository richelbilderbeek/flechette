## ----setup, include = FALSE----------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ------------------------------------------------------------------------
library(PBD)

## ------------------------------------------------------------------------
plot <- function(out) {
  graphics::par(mfrow = c(1, 4))
  cols <- stats::setNames(c("gray", "black"), c("i", "g"))
  phytools::plotSimmap(out$igtree.extant, colors = cols)

  sum_youngest <- sum(out$stree_youngest$edge.length)
  sum_oldest <- sum(out$stree_oldest$edge.length)
  sum_random <- sum(out$stree_random$edge.length)

  ape::plot.phylo(out$stree_oldest, edge.width = 2, font = 1,
    label.offset = 0.1, cex = 1, 
    main = paste("\n", "oldest", format(round(sum_oldest, 2), nsmall = 2)))
  ape::add.scale.bar()
  ape::plot.phylo(out$stree_youngest, edge.width = 2, font = 1,
    label.offset = 0.1, cex = 1, 
    main = paste("\n", "youngest", format(round(sum_youngest, 2), nsmall = 2)))
  ape::add.scale.bar()
  ape::plot.phylo(out$stree_random, edge.width = 2, font = 1,
    label.offset = 0.1, cex = 1, 
    main = paste("\n", "random", format(round(sum_random, 2), nsmall = 2)))
  ape::add.scale.bar()
  graphics::par(mfrow = c(1, 1))
}

## ------------------------------------------------------------------------
#' Create an example phylogeny
#' @param scr Speciation Completion Rate
#' @param sirg Speciation Initiation Rate of Good Species 
#' @param siri Speciation Initiation Rate of Incipient Species
#' @param sampling sampling method, can be 
#'  'expected', 
#'  'ylto' (youngest longer than oldest)
#'  'rsty' (random shorter than youngest)
#'  'rlto' (random longer than oldest)
create_example <- function(
  scr, 
  sirg, 
  siri, 
  sampling,
  erg = 0.0, 
  eri = 0.0, 
  crown_age = 1,
  min_n_species = 1,
  max_n_species = 10000,
  min_n_subspecies = 2,
  max_n_subspecies = 10000,
  rng_seed = 42
) {
  testit::assert(sampling %in% c("expected", "ylto", "rsty", "rlto"))
  
  set.seed(rng_seed)
  pbd_params <- c(sirg, scr, siri, erg, eri)
  while (TRUE) {  
    out <- PBD::pbd_sim(pars = pbd_params, age = crown_age, soc = 2)
    
    # Count subspecies
    n_subspecies <- length(out$igtree.extant$tip.label)
    if (n_subspecies < min_n_subspecies) next
    if (n_subspecies > max_n_subspecies) next
  
    # Count species
    n_species <- length(out$stree_youngest$tip.label)
    if (n_species < min_n_species) next
    if (n_species > max_n_species) next
  
    # Sum the branch lengths
    sum_youngest <- sum(out$stree_youngest$edge.length)
    sum_oldest <- sum(out$stree_oldest$edge.length)
    sum_random <- sum(out$stree_random$edge.length)

    # Only measure when they are different
    if (sum_youngest == sum_oldest) next
    
    if (sampling == "expected") {
      # No unexpected things
      if (sum_random < sum_youngest) next
      if (sum_random > sum_oldest) next
      if (sum_youngest > sum_oldest) next
      testit::assert(sum_youngest < sum_oldest)
      testit::assert(sum_youngest <= sum_random)
      testit::assert(sum_random <= sum_oldest)
    } else if (sampling == "ylto") {
      # Younger Less Than Oldest
      if (sum_youngest < sum_oldest) next
      testit::assert(sum_youngest > sum_oldest)
    } else if (sampling == "rsty") {
      # Random Shorter Than Youngest
      if (sum_youngest > sum_oldest) next
      if (sum_random >= sum_youngest) next
      if (sum_random >= sum_oldest) next
      testit::assert(sum_youngest < sum_oldest)
      testit::assert(sum_random < sum_youngest)
      testit::assert(sum_random < sum_oldest)
    } else if (sampling == "rlto") {
      if (sum_youngest > sum_oldest) next
      if (sum_random <= sum_youngest) next
      if (sum_random <= sum_oldest) next
      testit::assert(sum_youngest < sum_oldest)
      testit::assert(sum_random > sum_youngest)
      testit::assert(sum_random > sum_oldest)
    }
    
    # Found an example!    
    return(out)
  }
}

## ----fig.width=7, fig.height=5-------------------------------------------
out <- create_example(
  scr = 0.1, sirg = 2, siri = 2, sampling = "expected", 
  rng_seed = 42, max_n_subspecies = 3
)
plot(out)

## ----fig.width=7, fig.height=5-------------------------------------------
out <- create_example(scr = 0.5, sirg = 1, siri = 2, sampling = "expected",
  rng_seed = 51, 
  min_n_subspecies = 5, 
  max_n_subspecies = 10,
  min_n_species = 3
)
plot(out)

## ----fig.width=7, fig.height=5-------------------------------------------
out <- create_example(scr = 0.5, sirg = 1, siri = 2, sampling = "ylto",
  rng_seed = 51, 
  min_n_subspecies = 5, 
  max_n_subspecies = 10,
  min_n_species = 3
)
plot(out)

## ----fig.width=7, fig.height=5-------------------------------------------
out <- create_example(scr = 0.5, sirg = 1, siri = 2, sampling = "rsty",
  rng_seed = 51, 
  min_n_subspecies = 5, 
  max_n_subspecies = 10,
  min_n_species = 3
)
plot(out)

## ----fig.width=7, fig.height=5-------------------------------------------
out <- create_example(scr = 0.5, sirg = 1, siri = 2, sampling = "rlto",
  rng_seed = 51, 
  min_n_subspecies = 5, 
  max_n_subspecies = 10,
  min_n_species = 3
)
plot(out)

