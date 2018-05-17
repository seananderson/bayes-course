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
  "remotes"
)
have <- rownames(installed.packages())
needed <- setdiff(pkgs, have)

please_install(needed)

# Do you have the latest RStudio? ---------------------------------------

if (rstudioapi::getVersion() < "1.1.447") {
  cat("Please install the latest version of RStudio from https://www.rstudio.com/products/rstudio/download/\n")
}

# Do you have the latest R? ---------------------------------------

d <- sessionInfo()
r_version <- paste0(d$R.version$major, ".", gsub("\\.", "", d$R.version$minor))
if (r_version < "3.4") {
  cat("Please install the latest version of R from https://cran.r-project.org/\n")
}

# Do you have build tools? ---------------------------------------
devtools::has_devel()

# If not:

# On a Mac:
# Open the Terminal.app (see /Applications/Utilities/Terminal.app)
# Run:
# xcode-select --install

# On a PC:
# https://thecoatlessprofessor.com/programming/installing-rtools-for-compiled-code-via-rcpp/
# Makes sure to check the checkbox to modify your "path"!

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
  cat("Stan is working. Congratulations! You're done. You can ignore any warnings about 'Bayesian Fraction of Missing Information'.\n")
} else {
  cat("Stan is *not* working. Please contact Sean at <sean@seananderson.ca> or in person.\n")
}
