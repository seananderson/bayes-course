# examples of just MCMC chains to detect issues:
# - a chain is drifting but OK otherwise
# - chains are in separate places
# - chains are highly autocorrelated

# examples with brms:

# one example where you just haven't run it long enough

# one example where there's a pathology that goes away with
# a tighter prior and/or with a higher adapt delta


# are these samples consistent with convergence?
# if not, what helps you identify that?
# what might have caused this scenario?
# is this situation likely solvable?
# if so, what might improve the MCMC sampling?


# not long enough given autocorrelation:
set.seed(1)
s1 <- function(i) {
  x <- arima.sim(n = 500, list(ar = 0.97), sd = 0.3)
  x <- matrix(x, ncol = 1)
  colnames(x) <- "theta"
  x
}

samples <- purrr::map(1:4, s1)
names(samples) <- paste("Chain", 1:4)
samples_matrix <- do.call(cbind, samples)
bayesplot::mcmc_trace(samples)
rstan::Rhat(samples_matrix)
rstan::ess_bulk(samples_matrix)
rstan::ess_tail(samples_matrix)
saveRDS(samples, "data/mcmc1.rds")

# drifting:
set.seed(1)
s1 <- function(i) {
  N <- 500
  x <- arima.sim(n = N, list(ar = 0.5), sd = 0.3)
  x <- matrix(x, ncol = 1)
  colnames(x) <- "theta"
  x <- x + 1:500 * 0.0017
  x
}

samples <- purrr::map(1:4, s1)
names(samples) <- paste("Chain", 1:4)
samples_matrix <- do.call(cbind, samples)
saveRDS(samples, "data/mcmc2.rds")

bayesplot::mcmc_trace(samples)

rstan::Rhat(samples_matrix)
rstan::ess_bulk(samples_matrix)
rstan::ess_tail(samples_matrix)

# one chain getting stuck:
set.seed(1)
s1 <- function(i) {
  N <- 1000
  .ar <- ifelse(i == 1, 0.90, 0.4)
  x <- arima.sim(n = N, list(ar = .ar), sd = 0.3)
  x <- matrix(x, ncol = 1)
  colnames(x) <- "theta"
  x
}

samples <- purrr::map(1:4, s1)
names(samples) <- paste("Chain", 1:4)
samples_matrix <- do.call(cbind, samples)
bayesplot::mcmc_trace(samples)

rstan::Rhat(samples_matrix)
rstan::ess_bulk(samples_matrix)
rstan::ess_tail(samples_matrix)

saveRDS(samples, "data/mcmc3.rds")

# looks great
set.seed(1)
s1 <- function(i) {
  N <- 1000
  x <- arima.sim(n = N, list(ar = 0.75), sd = 0.3) + 2.2
  x <- matrix(x, ncol = 1)
  colnames(x) <- "theta"
  x
}

samples <- purrr::map(1:4, s1)
names(samples) <- paste("Chain", 1:4)
samples_matrix <- do.call(cbind, samples)

bayesplot::mcmc_trace(samples)

rstan::Rhat(samples_matrix)
rstan::ess_bulk(samples_matrix)
rstan::ess_tail(samples_matrix)

saveRDS(samples, "data/mcmc4.rds")

# stuck in slightly different places
set.seed(1)
s1 <- function(i) {
  mu <- c(0.4, 0, -0.1, 0.18)[i]
  N <- 1000
  x <- mu + arima.sim(n = N, list(ar = 0.6), sd = 0.3)
  x <- matrix(x, ncol = 1)
  colnames(x) <- "theta"
  x
}
samples <- purrr::map(1:4, s1)
names(samples) <- paste("Chain", 1:4)
samples_matrix <- do.call(cbind, samples)

bayesplot::mcmc_trace(samples)

rstan::Rhat(samples_matrix)
rstan::ess_bulk(samples_matrix)
rstan::ess_tail(samples_matrix)
saveRDS(samples, "data/mcmc5.rds")

# not enough warmup:
set.seed(1)
s1 <- function(i) {
  start <- c(-6, 8, 0, -1)[i]
  N <- 700
  x <- arima.sim(n = N, list(ar = 0.96), sd = 0.1, n.start = 1, start.innov = rep(start, 1))
  x <- matrix(x, ncol = 1)
  colnames(x) <- "theta"
  x
}

samples <- purrr::map(1:4, s1)
names(samples) <- paste("Chain", 1:4)
samples_matrix <- do.call(cbind, samples)

bayesplot::mcmc_trace(samples)

rstan::Rhat(samples_matrix)
rstan::ess_bulk(samples_matrix)
rstan::ess_tail(samples_matrix)

saveRDS(samples, "data/mcmc6.rds")
