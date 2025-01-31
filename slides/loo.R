library(rstanarm)
library(ggplot2)
theme_set(theme_light())
options(mc.cores = 1) # no parallel: faster for these simple regressions
library(dplyr)

x <- 1:20
n <- length(x)
a <- 0.2
b <- 0.3
sigma <- 1
set.seed(2141)
y <- a + b * x + sigma * rnorm(n)
fake <- data.frame(x, y)
fit_all <- stan_glm(y ~ x, data = fake, seed = 2141, chains = 10, refresh = 0)
fit_minus_18 <- stan_glm(y ~ x, data = fake[-18, ], seed = 2141, refresh = 0)
sims <- as.matrix(fit_all)
sims_minus_18 <- as.matrix(fit_minus_18)
condpred <- data.frame(y = seq(0, 9, length.out = 100))
condpred$x <- sapply(condpred$y, \(y)
  mean(dnorm(y, sims[, 1] + sims[, 2] * x[18], sims[, 3]) * 6 + 18))
condpredloo <- data.frame(y = seq(0, 9, length.out = 100))
condpredloo$x <- sapply(condpredloo$y, \(y)
mean(dnorm(y, sims_minus_18[, 1] + sims_minus_18[, 2] * x[18], sims_minus_18[, 3]) * 6 + 18))

ggplot(fake, aes(x = x, y = y)) +
  geom_point(color = "white", size = 3) +
  geom_point(color = "black", size = 2) +
  geom_abline(
    intercept = mean(sims[, 1]),
    slope = mean(sims[, 2]),
    color = "black"
  ) +
  geom_path(data = condpred, aes(x = x, y = y), color = "black") +
  geom_vline(xintercept = 18, linetype = 3, color = "grey") +
  geom_point(data = fake[18, ], color = "grey50", size = 5, shape = 1) +
  geom_abline(
    intercept = mean(sims_minus_18[, 1]),
    slope = mean(sims_minus_18[, 2]),
    color = "grey50",
    linetype = 2
  ) +
  geom_path(data = condpredloo, aes(x = x, y = y), color = "grey50", linetype = 2)
ggsave("slides/figs/loo-init-eg.png", width = 6, height = 4.5)

fake$residual <- fake$y - fit_all$fitted.values
fake$looresidual <- fake$y - loo_predict(fit_all)$value
ggplot(fake, aes(x = x, y = residual)) +
  geom_point(color = "black", size = 2, shape = 16) +
  geom_point(aes(y = looresidual), color = "grey50", size = 2, shape = 1) +
  geom_segment(aes(xend = x, y = residual, yend = looresidual)) +
  geom_hline(yintercept = 0, linetype = 2)
ggsave("slides/figs/loo-resid-eg.png", width = 6, height = 4.5)


S <- 10
y_hat <- matrix(nrow = S, ncol = n)
for (s in 1:S) {
  for (i in 1:n) {
    y_hat[s, i] <- sims[s, 1] + sims[s, 2] * x[i]
  }
}


y_i <- 10
xx <- seq(0, 7, length.out = 100)
mult <- 6

gg <- list()
for (s in 1:6) {
  yy <- sapply(xx, \(x) dnorm(x, mean = y_hat[s, y_i], sd = sims[s, 3], log = FALSE))
  df <- data.frame(x = xx, y = yy)

  df2 <- data.frame(x = y[y_i], y = dnorm(y[y_i], mean = y_hat[s, y_i], sd = sims[s, 3], log = FALSE)*mult + y_i)
  df2 <- rbind(data.frame(x = y[y_i], y = y_i), df2)

  gg[[s]] <- data.frame(x = x, y = y_hat[s,]) |>
    ggplot(aes(x, y)) +
    geom_line() +
    geom_point(data = data.frame(Var2 = y_i, value = y[y_i]), mapping = aes(Var2, value), inherit.aes = FALSE) +
    geom_path(data = df, mapping = aes(x = y_i + y * mult, y = x), inherit.aes = FALSE) +
    geom_path(data = df2, mapping = aes(x = y, y = x), colour = "red") +
    xlab("x") + ylab("y") +
    geom_point(data = fake, mapping = aes(x, y), inherit.aes = FALSE, pch = 21) +
    ggtitle(paste0("MCMC sample ", s))
}
gg[[1]]
ggsave("slides/figs/elpd1.png", width = 6, height = 4.5)
patchwork::wrap_plots(gg)
ggsave("slides/figs/elpd6.png", width = 10, height = 7)

S <- 50
y_hat <- matrix(nrow = S, ncol = n)
for (s in 1:S) {
  for (i in 1:n) {
    y_hat[s, i] <- sims[s, 1] + sims[s, 2] * x[i]
  }
}
reshape2::melt(y_hat) |>
  ggplot(aes(Var2, value, group = Var1)) +
  geom_line(alpha = 0.3) +
  xlab("x") + ylab("y") +
  geom_point(data = fake, mapping = aes(x, y), inherit.aes = FALSE, pch = 21)
ggsave("slides/figs/elpd-fits.png", width = 6, height = 4.5)

S <- 1000
y_hat <- matrix(nrow = S, ncol = n)
for (s in 1:S) {
  for (i in 1:n) {
    y_hat[s, i] <- sims[s, 1] + sims[s, 2] * x[i]
  }
}
ll_2 <- matrix(nrow = S, ncol = n)
for (s in 1:S) {
  for (i in 1:n) {
    ll_2[s, i] <- dnorm(y[i], mean = y_hat[s, i], sd = sims[s, 3], log = TRUE)
  }
}

df <- reshape2::melt(ll_2) |>
  filter(Var2 %in% 1:6) |>
  mutate(Var2 = paste("Data point", Var2))

df2 <- group_by(df, Var2) |>
  summarise(mean = mean(exp(value)))

df |>
  ggplot(aes(exp(value))) +
  facet_wrap(~Var2) +
  geom_histogram() + xlab("Likelihood") + ylab("MCMC sample count") +
  geom_vline(data = df2, mapping = aes(xintercept = mean), colour = "red") +
  coord_cartesian(expand = FALSE)
ggsave("slides/figs/elpd-dist.png", width = 7.5, height = 5)

lpd_2 <- log(apply(exp(ll_2), 2, mean)) # computationally dangerous!

sum(lpd_2)
