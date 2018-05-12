mcmc_example <- function(
  mu = 4, # the true mean; we will estimate this
  sigma = 5, # the true residual SD; we will assume we know this for simplicity
  .n = 30, # number of data points to simulate
  prior_mu = 0, # our prior distribution mean
  prior_mu_sd = 50, # our prior distribution SD on the mean
  # Next, the SD of our jump function.
  # Too small a value and the chain might take a
  # very long time to get to the right parameter space or might get stuck in the
  # wrong area of the parameter space.
  # Too large a value and the proposed values will be often rejected, and again,
  # the chain may get stuck and take a very long time to converge on an
  # appropriate answer.
  # This is something that a program like JAGS will pick for you.
  jump_sd = 5,
  thin = 10, # thinning interval
  reps = 10000 # the length of our MCMC chain
  ) {



  dat <- rnorm(.n, mean = mu, sd = sigma) # our simulated data

  # We will ensure that our data has exactly our specified mean.
  # (This is just to make the simulation easier to follow.)

  dat <- dat - (mean(dat) - mu)

  # A vector to hold our MCMC chain output:
  out <- vector(length = reps, mode = "numeric")

  # We'll start at an initial value of 0:
  out[1] <- 0

  # Now we'll loop through our MCMC chain:
  for(i in seq(2, length(out))) {

    # Propose a new value given the previous value and the jump SD:
    proposal <- rnorm(1, out[1], jump_sd)

    # Calculate the log-likelihood of the data given the proposed parameter value
    # and the previous parameter value:
    like_proposal <- sum(dnorm(dat, mean = proposal, sd = sigma, log = TRUE))
    like_previous <- sum(dnorm(dat, mean = out[i-1], sd = sigma, log = TRUE))

    # Get the log-probability of the proposed and previous parameter values given
    # the prior:
    prior_proposal <- dnorm(proposal, mean = prior_mu, sd = prior_mu_sd, log = TRUE)
    prior_previous <- dnorm(out[i-1], mean = prior_mu, sd = prior_mu_sd, log = TRUE)

    # Combine the log-prior with the log-likelihood to get a value that is
    # proportional to the posterior probability of that parameter value given the
    # data:
    posterior_proposal <- prior_proposal + like_proposal
    posterior_previous <- prior_previous + like_previous

    # Calculate the ratio of the proposal and previous probabilities:
    prob_ratio <- exp(posterior_proposal - posterior_previous)

    # If the probability ratio is > 1, then always accept the new parameter
    # values.
    # If the probability ratio is < 1, then accept the new parameter values in
    # proportion to the ratio.
    if(runif(1, min = 0, max = 1) < prob_ratio) {
      out[i] <- proposal # use the proposed parameter value
    } else {
      out[i] <- out[i-1] # keep the previous parmaeter value
    }
  }
  burnt_out <- round(reps/2):length(out)
  burnt_out <- seq(min(burnt_out), max(burnt_out), thin)
  par(mfrow = c(1, 3))
  plot(dat)
  plot(burnt_out, out[burnt_out], type = "l", xlab = "Chain index",
    ylab = expression(widehat(mu)), col = "#00000050") # the MCMC chain
  abline(h = mu, col = "red", lty = 1, lwd = 2) # the true mean
  # abline(h = mean(out[burnt_out]), col = "grey50", lwd = 2, lty = 2)
  # hist(out[burnt_out], main = "", xlab = expression(widehat(mu)), xlim = c(-5, 5))
  plot(density(out[burnt_out]), xlim = c(-5, 5))
  abline(v = mu, col = "red", lty = 1, lwd = 2)
  # abline(v = mean(out[burnt_out]), col = "grey50", lwd = 2, lty = 2)
  xx <- seq(-10, 10, length.out = 200)
  yy <- dnorm(xx, mean = prior_mu, sd = prior_mu_sd)
  par(new = TRUE)
  plot(xx, yy, ylim = c(0, max(yy)), type = "l", axes = FALSE, ann = FALSE,
    xlim = c(-5, 5))
  invisible(out)
}

library(manipulate)
manipulate(mcmc_example(mu = mu, sigma = sigma, .n = .n, prior_mu = prior_mu, prior_mu_sd = prior_mu_sd, jump_sd = jump_sd, thin = thin, reps = reps), mu = slider(0, 5, 1), sigma = slider(0.1, 10, 5), .n = slider(2, 1000, 25), prior_mu = slider(-10, 10, 0), prior_mu_sd = slider(0.1, 100, 2, step = 0.1), jump_sd = slider(0.1, 50, 10, step = 0.1), thin = slider(1, 100, 5), reps = slider(30, 200000, 20000))
