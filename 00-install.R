# The first half is adapted from Hadley Wickham's install script.

# A polite helper for installing packages ---------------------------------

please_install <- function(pkgs, install_fun = install.packages) {
  if (length(pkgs) == 0) {
    return(invisible())
  }
  if (!interactive()) {
    stop("Please run in interactive session", call. = FALSE)
  }

  title <- paste0(
    "Ok to install these packges?\n",
    paste("* ", pkgs, collapse = "\n")
  )
  ok <- menu(c("Yes", "No"), title = title) == 1

  if (!ok) {
    return(invisible())
  }

  install_fun(pkgs)
}

# Do you have all the needed packages? ------------------------------------

pkgs <- c(
  "tidyverse", "rstan", "rstanarm", "brms", "rmarkdown",
  "manipulate", "shiny", "usethis", "bayesplot", "loo",
  "devtools", "gridExtra", "patchwork", "extraDistr", "coda"
)
have <- rownames(installed.packages())
needed <- setdiff(pkgs, have)

please_install(needed)

# Do you have build tools? ---------------------------------------
devtools::has_devel()

# If not:

# On a Mac:
# Open the Terminal.app (see /Applications/Utilities/Terminal.app)
# Run:
# xcode-select --install

# On a PC:
# Install the Rtools version that matches your version of R
# DFO users can find this in the Software Center

# Restart R

# Did it work?
devtools::has_devel()

# Stan working? ---------------------------------------

library("rstan")
scode <- "
parameters {
  real y[2];
}
model {
  y[1] ~ normal(0, 1);
  y[2] ~ double_exponential(0, 2);
}
"
cat("Please wait a minute while the model compiles.\n")
fit1 <- stan(model_code = scode, iter = 50, verbose = FALSE, chains = 1)

if (identical(class(fit1)[[1]], "stanfit")) {
  cat("Stan is working. Congratulations! You're done. You can ignore any warnings about 'R-hat' and 'Effective Samples Size (ESS)' above\n")
} else {
  cat("Stan is *not* working. Please ask ask a coworker or contact Sean.\n")
}
