ratio <- 0.68
width <- 8
dat <- expand.grid(x = 1:40, y = 1:25)
dat$colour <- "a"

ggplot(dat, aes(x, y, colour = colour)) +
  geom_point(size = 4) +
  theme_void() +
  scale_color_manual(values = c("a" = "grey70", "b" = "red")) +
  guides(colour = FALSE)
ggsave("extra/bayes-dots-0.pdf", width = width, height = ratio * width)

dat$colour[450] <- "b"
ggplot(dat, aes(x, y, colour = colour)) +
  geom_point(size = 4) +
  theme_void() +
  scale_color_manual(values = c("a" = "grey70", "b" = "red")) +
  guides(colour = FALSE)
ggsave("extra/bayes-dots-1.pdf", width = width, height = ratio * width)

set.seed(1)
has_disease <- sample(seq_len(1000), size = 50)
dat$colour[has_disease] <- "c"
ggplot(dat, aes(x, y, colour = colour)) +
  geom_point(size = 4) +
  theme_void() +
  scale_color_manual(values = c("a" = "grey70", "b" = "red", "c"= "black")) +
  guides(colour = FALSE)
ggsave("extra/bayes-dots-2.pdf", width = width, height = ratio * width)

dat2 <- data.frame(x = c(1:25, 1:25), y = c(rep(1, 25), rep(2, 25)), colour = "c", stringsAsFactors = FALSE)
dat2$colour[8] <- "b"
ggplot(dat2, aes(x, y, colour = colour)) +
  geom_point(size = 8) +
  theme_void() +
  ylim(-4, 7) +
  scale_color_manual(values = c("a" = "grey70", "b" = "red", "c"= "black")) +
  guides(colour = FALSE)
ggsave("extra/bayes-dots-3.pdf", width = width, height = ratio * width)
