library(ggplot2)
library(dplyr)
fill <- "#00000010"
col <- "grey20"

x <- seq(-5, 5, length.out = 1000)
ggplot(tibble(x, y = dnorm(x, 0, 1)), aes(x, ymax = y)) +
  geom_ribbon(ymin = 0, fill = fill, col = col) +
  theme_void()
ggsave("extra/dist-normal.pdf", width = 6, height = 6 * 0.618)

x <- seq(0, 5, length.out = 1000)
ggplot(tibble(x, y = dnorm(x, 0, 1)), aes(x, ymax = y)) +
  geom_ribbon(ymin = 0, fill = fill, col = col) +
  ylim(0, NA) +
  theme_void()
ggsave("extra/dist-half-normal.pdf", width = 6, height = 6 * 0.618)

x <- seq(-1, 1, length.out = 1000)
ggplot(tibble(x, y = dnorm(x, 0, 0.7)), aes(x, ymax = y)) +
  geom_ribbon(ymin = 0, fill = fill, col = col) +
  ylim(0, NA) +
  theme_void()
ggsave("extra/dist-truncated-normal.pdf", width = 6, height = 6 * 0.618)

x <- seq(-5, 5, length.out = 1000)
ggplot(tibble(x, ynorm = dnorm(x = x, 0, 1),
  y = dt(x = x, df = 3)), aes(x, ymax = y)) +
  geom_ribbon(ymin = 0, fill = fill, col = col) +
  geom_ribbon(ymin = 0, aes(ymax = ynorm), fill = NA,
    colour = "grey10", lty = 2) +
  ylim(0, NA) +
  theme_void()
ggsave("extra/dist-t.pdf", width = 6, height = 6 * 0.618)

x <- seq(0, 5, length.out = 1000)
ggplot(tibble(x, ynorm = dnorm(x = x, 0, 1),
  y = dt(x = x, df = 3)), aes(x, ymax = y)) +
  geom_ribbon(ymin = 0, fill = fill, col = col) +
  geom_ribbon(ymin = 0, aes(ymax = ynorm), fill = NA,
    colour = "grey10", lty = 2) +
  ylim(0, NA) +
  theme_void()
ggsave("extra/dist-half-t.pdf", width = 6, height = 6 * 0.618)

x <- seq(-10, 10, length.out = 1000)
ggplot(tibble(x, ynorm = dnorm(x = x, 0, 1),
  y = dcauchy(x = x)), aes(x, ymax = y)) +
  geom_ribbon(ymin = 0, fill = fill, col = col) +
  geom_ribbon(ymin = 0, aes(ymax = ynorm), fill = NA,
    colour = "grey10", lty = 2) +
  ylim(0, NA) +
  theme_void()
ggsave("extra/dist-cauchy.pdf", width = 6, height = 6 * 0.618)

x <- seq(0, 10, length.out = 1000)
ggplot(tibble(x, ynorm = dnorm(x = x, 0, 1),
  y = dcauchy(x = x)), aes(x, ymax = y)) +
  geom_ribbon(ymin = 0, fill = fill, col = col) +
  geom_ribbon(ymin = 0, aes(ymax = ynorm), fill = NA,
    colour = "grey10", lty = 2) +
  ylim(0, NA) +
  theme_void()
ggsave("extra/dist-half-cauchy.pdf", width = 6, height = 6 * 0.618)

x <- seq(0, 100, length.out = 1000)
ggplot(tibble(x, y = dexp(x = x, rate = 0.1),
  y2 = dexp(x = x, rate = 0.2)), aes(x, ymax = y)) +
  geom_ribbon(ymin = 0, fill = fill, col = col) +
  geom_ribbon(ymin = 0, fill = fill, col = col, aes(ymax = y2)) +
  ylim(0, NA) +
  theme_void()
ggsave("extra/dist-exp.pdf", width = 6, height = 6 * 0.618)

x <- seq(0, 15, length.out = 1000)
ggplot(tibble(x,
  y = dgamma(x = x, shape = 5, rate = 1),
  y2 = dgamma(x = x, shape = 2, rate = 1),
  y3 = dgamma(x = x, shape = 1, rate = 1)),
  aes(x, ymax = y)) +
  geom_ribbon(ymin = 0, fill = fill, col = col) +
  geom_ribbon(ymin = 0, fill = fill, col = col, aes(ymax = y2)) +
  geom_ribbon(ymin = 0, fill = fill, col = col, aes(ymax = y3)) +
  ylim(0, NA) +
  theme_void()
ggsave("extra/dist-gamma.pdf", width = 6, height = 6 * 0.618)

x <- seq(0, 1, length.out = 1000)
ggplot(tibble(x,
  y = dbeta(x = x, shape1 = 2, shape2 = 2),
  y2 = dbeta(x = x, shape = 0.8, shape2 = 0.8),
  y3 = dbeta(x = x, shape = 3, shape2 = 1),
  y4 = dbeta(x = x, shape = 1, shape2 = 3)),
  aes(x, ymax = y)) +
  ylim(0, NA) +
  geom_ribbon(ymin = 0, fill = fill, col = col) +
  geom_ribbon(ymin = 0, fill = fill, col = col, aes(ymax = y2)) +
  geom_ribbon(ymin = 0, fill = fill, col = col, aes(ymax = y3)) +
  geom_ribbon(ymin = 0, fill = fill, col = col, aes(ymax = y4)) +
  theme_void()
ggsave("extra/dist-beta.pdf", width = 6, height = 6 * 0.618)

x <- seq(0, 1, length.out = 1000)
ggplot(tibble(x,
  y = dbinom(x = 3, size = 4, prob = x),
  y2 = dbinom(x = 1, size = 5, prob = x),
  y3 = dbinom(x = 2, size = 4, prob = x)),
  aes(x, ymax = y)) +
  ylim(0, NA) +
  geom_ribbon(ymin = 0, fill = fill, col = col) +
  geom_ribbon(ymin = 0, fill = fill, col = col, aes(ymax = y2)) +
  geom_ribbon(ymin = 0, fill = fill, col = col, aes(ymax = y3)) +
  # geom_ribbon(ymin = 0, fill = fill, col = col, aes(ymax = y4)) +
  theme_void()
ggsave("extra/dist-binom.pdf", width = 6, height = 6 * 0.618)

x <- seq(0, 20, length.out = 1000)
ggplot(tibble(x,
  y = invgamma::dinvgamma(x, shape = 1, rate = 1)),
  aes(x, ymax = y)) +
  geom_ribbon(ymin = 0, fill = fill, col = col) +
  geom_vline(xintercept = 0, lty = 2) +
  ylim(0, NA) +
  theme_void()
ggsave("extra/dist-inv-gamma.pdf", width = 6, height = 6 * 0.618)

x <- seq(0, 20, length.out = 1000)
ggplot(tibble(x,
  y = dunif(x, 0, 20)),
  aes(x, ymax = y)) +
  geom_ribbon(ymin = 0, fill = fill, col = col) +
  ylim(0, 0.1) +
  theme_void()
ggsave("extra/dist-uniform.pdf", width = 6, height = 6 * 0.618)


