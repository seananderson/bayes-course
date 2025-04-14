# Demo of the influence of priors in regression

# Goals
# - Gain some intuition about the influence of priors on a Bayesian regression

# In the plots, the gray histograms represent the posterior samples, the blue
# lines represent the priors, and the red lines represent the true values. The
# last panel represents the simulated data (dots), the true relationship
# between y and x (red line), and 50 draws from the posterior distribution.

# Try running the following code chunk and adjusting the argument values. If
# you adjust the `seed` slider, you will change the random number generator
# draw.

# Remember that the choice of scale or standard deviation value for the priors
# is dependent on the scale of the predictor and response variable.

# You may consider asking questions like:
#
# - What happens if you have a tight prior on the slope coefficient that
#   differs from the true value?
# - How does this change when you have a lot of data vs. a little?
# - How much data do I need before the data overwhelm the prior for a given
#   discrepancy between the prior and data?
# - What happens with a very diffuse prior on the slope coefficient and very
#   few data points?
# - Can having an informative prior on the slope coefficient help if you've
#   collected very little data? When might you have this kind of information?

library(rstanarm)
library(ggplot2)
theme_set(theme_light())
library(shiny)

mcmc_example <- function(
    seed = 1,
    intercept = 3,
    slope = 0.7,
    sigma = 2, # the true residual SD
    .n = 30, # number of data points to simulate
    prior_slope_mean = 0,
    prior_slope_sd = 3,
    prior_intercept_sd = 10,
    prior_sigma_sd = 3,
    reps = 800 # the length of each MCMC chain
    ) {
  set.seed(seed)
  x <- rnorm(.n, 0, .5)
  d <- data.frame(x = x, y = rnorm(.n, mean = intercept + slope * x, sd = sigma))

  suppressWarnings(
    m <- rstanarm::stan_glm(y ~ x, d,
      iter = reps, chains = 1,
      family = gaussian(link = "identity"), refresh = 0,
      prior = normal(prior_slope_mean, prior_slope_sd, autoscale = FALSE),
      prior_intercept = normal(0, prior_intercept_sd, autoscale = FALSE),
      prior_aux = normal(0, prior_sigma_sd, autoscale = FALSE),
      chains = 1, seed = seed
    )
  )

  e <- as.data.frame(m)
  xx <- seq(-6, 6, length.out = 100)

  slope_prior <- data.frame(
    x = xx,
    y = dnorm(xx, mean = prior_slope_mean, sd = prior_slope_sd)
  )

  intercept_prior <- data.frame(
    x = xx,
    y = dnorm(xx, mean = 0, sd = prior_intercept_sd)
  )

  xx0 <- seq(0, 6, length.out = 100)
  sigma_prior <- data.frame(
    x = xx0,
    y = extraDistr::dhnorm(xx0, sigma = prior_sigma_sd)
  )

  .range <- c(-4, 4)

  g1 <- ggplot(e, aes(`(Intercept)`, after_stat(density))) +
    geom_histogram(bins = 50) +
    geom_line(data = intercept_prior, aes(x, y), col = "blue") +
    coord_cartesian(xlim = .range) +
    xlab("Intercept") +
    geom_vline(xintercept = intercept, col = "red")

  g2 <- ggplot(e, aes(x, after_stat(density))) +
    geom_histogram(bins = 50) +
    geom_line(data = slope_prior, aes(x, y), col = "blue") +
    coord_cartesian(xlim = .range) +
    xlab("Slope coefficient") +
    geom_vline(xintercept = slope, col = "red")

  g3 <- ggplot(e, aes(sigma, after_stat(density))) +
    geom_histogram(bins = 50) +
    geom_line(data = sigma_prior, aes(x, y), col = "blue") +
    coord_cartesian(xlim = c(0, max(.range))) +
    xlab("Observation error SD") +
    geom_vline(xintercept = sigma, col = "red")

  nd <- data.frame(x = seq(-1, 1, length.out = 2))
  set.seed(seed)
  pp <- posterior_linpred(m, newdata = nd, draws = 50)
  pp2 <- reshape2::melt(pp)
  pp2$x <- rep(nd$x, each = 50)

  g4 <- ggplot(d, aes(x = x, y = y)) +
    geom_point() +
    geom_line(
      data = pp2, aes(x, value, group = iterations), inherit.aes = FALSE,
      alpha = 0.5, col = "grey30"
    ) +
    geom_abline(
      slope = slope, intercept = intercept,
      col = "red"
    )

  patchwork::wrap_plots(g1, g2, g3, g4, ncol = 2)
}

ui <- fluidPage(
  pageWithSidebar(
    titlePanel("Regression prior explorer"),
    sidebarPanel(
      sliderInput("seed", "Random seed value", value = 1, min = 1, max = 200, step = 1),
      sliderInput("slope", "True slope coefficient", value = 0.6, min = -2, max = 2, step = 0.2),
      sliderInput("sigma", "True observation error SD (sigma)", value = 1, min = 0.1, max = 8, step = 0.1),
      sliderInput(".n", "Number of observations", value = 50, min = 2, max = 1000, step = 2),
      sliderInput("prior_slope_mean", "Slope prior mean", value = 0, min = -5, max = 5, step = 0.5),
      sliderInput("prior_slope_sd", "Slope prior SD", value = 1, min = 0.1, max = 100, step = .1),
      sliderInput("prior_sigma_sd", "Sigma prior SD", value = 1, min = 0.1, max = 50, step = 1)
    ),
    mainPanel(plotOutput("gg"))
  )
)
server <- function(input, output, session) {
  output$gg <- renderPlot(
    {
      mcmc_example(
        seed = input$seed,
        intercept = 0,
        slope = input$slope,
        sigma = input$sigma,
        .n = input$.n,
        prior_slope_mean = input$prior_slope_mean,
        prior_slope_sd = input$prior_slope_sd,
        prior_sigma_sd = input$prior_sigma_sd
      )
    },
    width = 600,
    height = 500
  )
}

shinyApp(ui, server)
