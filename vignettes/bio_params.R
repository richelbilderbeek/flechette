## ----setup, include = FALSE----------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ------------------------------------------------------------------------
ers <- c(0.0, 0.1, 0.2)
ns <- c(50, 100, 200)
scrs <- c(0.1, 0.3, 1.0, 1e9)

## ------------------------------------------------------------------------
df_goal <- expand.grid(er = ers, n = ns, scr = scrs)
df_goal$sir <- "?"
knitr::kable(df_goal)

## ------------------------------------------------------------------------
crown_age <- 15

## ------------------------------------------------------------------------
library(ggplot2)

## ------------------------------------------------------------------------
scr <- max(df_goal$scr)

## ----fig.width=7---------------------------------------------------------
n_points <- 11
min_sir <- 0.1
max_sir <- 0.7
min_er <- min(df_goal$er)
max_er <- max(df_goal$er)
df_grid <- data.frame(
  sir = rep(seq(min_sir, max_sir, length.out = n_points), each = n_points),  
  er = rep(seq(min_er, max_er, length.out = n_points), times = n_points)
)
df_grid$n <- becosys::pbd_numspec_mean_checked(
  ergs = df_grid$er, 
  eris = df_grid$er, 
  scr = rep(scr, nrow(df_grid)), 
  sirs = df_grid$sir, 
  crown_ages = rep(crown_age, nrow(df_grid))
)
plot_bd <- ggplot(df_grid, aes(sir, er, z = n)) + 
  geom_raster(aes(fill = n)) + 
  geom_contour(breaks = ns, color = "green") +
  geom_hline(yintercept = ers, color = "red")
plot_bd

## ------------------------------------------------------------------------
df_bd <- df_goal[ df_goal$scr == 1e9, ]
df_bd$sir <- rep("?", nrow(df_bd))
knitr::kable(df_bd)

## ------------------------------------------------------------------------
# The difference between the mean number of species as produced by the
# BD model and the desired number of species
sir_error <- function(sir, known_er, known_scr, known_crown_age, n_desired) {
  becosys::pbd_numspec_mean_checked( 
    ergs = known_er, 
    eris = known_er, 
    scrs = known_scr, 
    sirs = sir,
    crown_age = known_crown_age
  ) - n_desired
}

for (row in seq_along(df_bd$sir)) {
  er <- df_bd$er[row]
  n <- df_bd$n[row]
  scr <- df_bd$scr[row]
  f <- functional::Curry(
    sir_error,
    known_er = er, 
    known_scr = scr, 
    known_crown_age = crown_age,
    n_desired = n
  )
  df_bd$sir[row] <- uniroot(f, interval = c(0.2, 1.6))$root
}
knitr::kable(df_bd)

## ----fig.width=7---------------------------------------------------------
plot_bd + geom_point(data = df_bd, aes(x = as.numeric(sir), y = as.numeric(er)))

## ------------------------------------------------------------------------
for (row in seq_along(df_goal$sir)) {
  er <- df_goal$er[row]
  n <- df_goal$n[row]
  scr <- df_goal$scr[row]
  f <- functional::Curry(
    sir_error,
    known_er = er, 
    known_scr = scr, 
    known_crown_age = crown_age,
    n_desired = n
  )
  df_goal$sir[row] <- uniroot(f, interval = c(0.1, 2.0))$root
}
write.csv(df_goal, "raket_parameters.csv")
knitr::kable(df_goal)

## ----fig.width=7---------------------------------------------------------
plot <- function(scr, df_goal) {
  n_points <- 11
  min_sir <- min(df_goal$sir)
  max_sir <- max(df_goal$sir)
  min_er <- min(df_goal$er)
  max_er <- max(df_goal$er)
  df_grid <- data.frame(
    sir = rep(seq(min_sir, max_sir, length.out = n_points), each = n_points),  
    er = rep(seq(min_er, max_er, length.out = n_points), times = n_points)
  )
  df_grid$n <- becosys::pbd_numspec_mean_checked(
    ergs = df_grid$er, 
    eris = df_grid$er, 
    scr = rep(scr, nrow(df_grid)), 
    sirs = df_grid$sir, 
    crown_ages = rep(crown_age, nrow(df_grid))
  )
  df_goal_this_scr <- df_goal[ df_goal$scr == scr, ]
  plot_bd <- ggplot(df_grid, aes(sir, er, z = n)) + 
    geom_raster(aes(fill = n)) + 
    geom_contour(breaks = ns, color = "green") +
    geom_hline(yintercept = ers, color = "red") +
    geom_point(
      data = df_goal_this_scr, 
      x = as.numeric(df_goal_this_scr$sir),
      y = as.numeric(df_goal_this_scr$er)
    ) +
    ggtitle(paste("SCR:", scr))
  plot_bd
}
plot(scrs[1], df_goal)
plot(scrs[2], df_goal)
plot(scrs[3], df_goal)
plot(scrs[4], df_goal)

