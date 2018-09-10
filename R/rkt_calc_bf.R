#' Calculate the Bayes factor from model A's point of view,
#' following the method described in 
#' @param log_likelihoods_a log-likelihoods of model A
#' @param log_likelihoods_b log-likelihoods of model B
#' @return the Bayes factor from model A's point of view
#' @author Richel J.C. Bilderbeek
#' @references
#'    * [1] Drummond, Alexei J., and Remco R. Bouckaert. Bayesian evolutionary analysis with BEAST. Cambridge University Press, 2015. \cr
#'    * [2] Newton, Michael A., and Adrian E. Raftery. "Approximate Bayesian inference with the weighted likelihood bootstrap." Journal of the Royal Statistical Society. Series B (Methodological) (1994): 3-48. \cr 
rkt_calc_bf <- function(log_likelihoods_a, log_likelihoods_b) {
  # Harmonic Mean Estimate of the log marginal likelihood
  hme_log_marg_lik_a <- rkt_calc_harm_mean(log_likelihoods_a)
  hme_log_marg_lik_b <- rkt_calc_harm_mean(log_likelihoods_b)
  log_bf <- hme_log_marg_lik_a - hme_log_marg_lik_b
  exp(log_bf)
}

#' Calculate the Bayes factor from model A's point of view,
#' @param log_likelihoods_a log-likelihoods of model A
#' @param log_likelihoods_b log-likelihoods of model B
#' @return the Bayes factor from model A's point of view
#' @author Rampal S. Etienne, modified by Richel J.C. Bilderbeek
#' @export
rkt_calc_bf_rse <- function(log_likelihoods_a, log_likelihoods_b) {
  microsnail_BEAST2_results_log_files <- list()
  microsnail_BEAST2_results_log_files[[1]] <- data.frame(likelihood = log_likelihoods_a)
  microsnail_BEAST2_results_log_files[[2]] <- data.frame(likelihood = log_likelihoods_b)
  listname <- microsnail_BEAST2_results_log_files
  names(listname) <- c("AAAAA", "BBBBB")
  lengthlist <- length(microsnail_BEAST2_results_log_files)
  namei <- rep(0,lengthlist)
  meanll <- rep(0,lengthlist)
  harmmeanll <- rep(0,lengthlist)
  for(i in 1:lengthlist)
  {
    ll <- as.numeric(listname[[i]]$likelihood)
    minll <- min(ll)
    harmmeanll[i] <- log(length(ll)) + minll - sum(exp(-(ll - minll)))
    meanll[i] <- mean(ll)
    namei[i] <- names(listname)[i]
    namei[i] <- substr(namei[i],1,nchar(namei[i])-4)
  }
  BF <- rep(0,lengthlist)
  for(i in 1:(lengthlist/2))
  {
    BF[i] <- harmmeanll[i] - harmmeanll[lengthlist/2 + i]
  }
  for(i in (lengthlist/2 + 1):lengthlist)
  {
    BF[i] <- harmmeanll[i] - harmmeanll[-lengthlist/2 + i]
  }
  data.frame(namei,meanll,harmmeanll,BF)
}