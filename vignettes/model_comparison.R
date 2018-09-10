## ------------------------------------------------------------------------
# Extinction rates
ers <- c(0.0, 0.1, 0.2)

# Number of species
ns <- c(50, 100, 200)

# Speciation completion rate
scrs <- c(0.1, 0.3, 1.0, 1e9)

# Replicate index (human counting)
reps <- seq(1, 10)

## ------------------------------------------------------------------------
df <- expand.grid(er = ers, n = ns, scr = scrs, rep = reps)

# Bayes factor
df$bf <- "?"
knitr::kable(head(df))

## ------------------------------------------------------------------------
interpret_bayes_factor <- function(bayes_factor) {
  if (bayes_factor < 10^-2.0) {
    "decisive for GTR"
  } else if (bayes_factor < 10^-1.5) {
    "very strong for GTR"
  } else if (bayes_factor < 10^-1.0) {
    "strong for GTR"
  } else if (bayes_factor < 10^-0.5) {
    "substantial for GTR"
  } else if (bayes_factor < 10^0.0) {
    "barely worth mentioning for GTR"
  } else if (bayes_factor < 10^0.5) {
    "barely worth mentioning for JC69"
  } else if (bayes_factor < 10^1.0) {
    "substantial for JC69"
  } else if (bayes_factor < 10^1.5) {
    "strong for JC69"
  } else if (bayes_factor < 10^2.0) {
    "very strong for JC69"
  } else {
    "decisive for JC69"
  }
}
testit::assert(interpret_bayes_factor(1 / 123.0) == "decisive for GTR")
testit::assert(interpret_bayes_factor(1 / 85.0) == "very strong for GTR")
testit::assert(interpret_bayes_factor(1 / 12.5) == "strong for GTR")
testit::assert(interpret_bayes_factor(1 / 8.5) == "substantial for GTR")
testit::assert(interpret_bayes_factor(1 / 1.5) == "barely worth mentioning for GTR")
testit::assert(interpret_bayes_factor(0.99) == "barely worth mentioning for GTR")
testit::assert(interpret_bayes_factor(1.01) == "barely worth mentioning for JC69")
testit::assert(interpret_bayes_factor(1.5) == "barely worth mentioning for JC69")
testit::assert(interpret_bayes_factor(8.5) == "substantial for JC69")
testit::assert(interpret_bayes_factor(12.5) == "strong for JC69")
testit::assert(interpret_bayes_factor(85.0) == "very strong for JC69")
testit::assert(interpret_bayes_factor(123.0) == "decisive for JC69")

## ------------------------------------------------------------------------
df$bf <- runif(n = nrow(df))

## ------------------------------------------------------------------------
df$bfi <- "?"
for (row in seq(1, nrow(df)))
{
  df$bfi[row] <- interpret_bayes_factor(df$bf[row])
}
df$bfi <- as.factor(df$bfi)

## ------------------------------------------------------------------------
knitr::kable(head(df))

## ----fig.width = 7-------------------------------------------------------
is.factor(df$bfi)
library(ggplot2)
ggplot(
  data = df,
  aes(x = as.factor(scr), fill = bfi)
) + geom_bar() + facet_grid(as.factor(n) ~ as.factor(er)) + 
  ggtitle("How often is which model favored?")

