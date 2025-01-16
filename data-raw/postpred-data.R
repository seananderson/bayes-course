# should be quadratic:
x <- rnorm(100)
n <- length(x)
a <- 0.2
b <- 0.2
b2 <- -0.3
sigma <- 0.3
set.seed(2141)
y <- a + b * x + b2 * x^2 + sigma * rnorm(n)
df <- data.frame(x, y)
plot(df)

library(rstanarm)

fit <- stan_glm(
  y ~ x,
  data = df,
  iter = 500,
  chains = 1, seed = 129
)


p <- rstanarm::posterior_predict(fit)

y <- df$y
yrep <- p[1:20, ]
bayesplot::ppc_dens_overlay(y, yrep)
bayesplot::ppc_error_scatter_avg_vs_x(y, yrep, df$x)
bayesplot::ppc_intervals(y, yrep, x = df$x)

plot(df$x, y)
plot(df$x, yrep[1,])
plot(df$x, yrep[2,])

saveRDS(df, "data/ppcheck-df1.rds")
saveRDS(yrep, "data/ppcheck-yrep1.rds")

# not enough dispersion:
x <- rnorm(100)
n <- length(x)
a <- 1
b <- 0.4
set.seed(2141)
y <- MASS::rnegbin(n, exp(a + b * x), theta = 0.2)
df <- data.frame(x, y)
plot(df)

fit <- stan_glm(
  y ~ x,
  family = poisson(),
  data = df,
  iter = 500,
  chains = 1, seed = 291
)

plot(df)
y <- df$y
p <- rstanarm::posterior_predict(fit)
yrep <- p[1:20, ]
plot(df$x, df$y)
plot(df$x, yrep[1,])
plot(df$x, yrep[2,])
bayesplot::ppc_dens_overlay(y, yrep)

saveRDS(df, "data/ppcheck-df2.rds")
saveRDS(yrep, "data/ppcheck-yrep2.rds")

# # missing some major variable
# set.seed(1)
# library(MASS)
# Sigma <- matrix(c(10,3,3,2),2,2)
# Sigma
# x <- mvrnorm(n = 100, rep(0, 2), Sigma)
# plot(x)
# n <- nrow(x)
# a <- 1
# b1 <- 0.2
# b2 <- -2
# set.seed(2141)
# x1 <- x[,1]
# x2 <- x[,2]
# y <- rnorm(n, a + b * x1 + b2 * x2, 0.2)
# df <- data.frame(x1, x2, y)
# plot(df$x1, df$y)
# plot(df$x2, df$y)
#
# fit <- stan_glm(
#   y ~ x1,
#   data = df,
#   iter = 500,
#   chains = 1
# )
#
# p <- rstanarm::posterior_predict(fit)
# yrep <- p[1:20, ]
# plot(df$x1, df$y)
# plot(df$x1, yrep[1,])
# plot(df$x1, yrep[2,])
# plot(df$x2, yrep[2,])
# bayesplot::ppc_dens_overlay(y, yrep)
# bayesplot::ppc_error_scatter_avg_vs_x(y, yrep, df$x2)

# missing group

set.seed(1)
x <- rnorm(200)
a <- rnorm(5, 1, 2)
b <- 0.9
g <- rep(1:5, each = 40)
y <- rnorm(n, a[g] + b * x, 0.2)
df <- data.frame(x, y, g = factor(g))
ggplot(df, aes(x, y, colour = g)) + geom_point()

fit <- stan_glm(
  y ~ x,
  data = df,
  iter = 500,
  chains = 1, seed = 292
)

p <- rstanarm::posterior_predict(fit)
ggplot(df, aes(x, y)) + geom_point()

y <- df$y
yrep <- p[1:20, ]

plot(df$x, yrep[1,])
plot(df$x, yrep[2,])
plot(df$x, yrep[3,])

bayesplot::ppc_dens_overlay(y, yrep)
bayesplot::ppc_dens_overlay_grouped(y, yrep, df$g)

df$yrep2 <- yrep[2,]
ggplot(df, aes(x, y, colour = g)) + geom_point()
ggplot(df, aes(x, yrep2, colour = g)) + geom_point()

saveRDS(df, "data/ppcheck-df3.rds")
saveRDS(yrep, "data/ppcheck-yrep3.rds")
