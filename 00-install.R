# Because of our limited time, it is critical that you arrive with all of the
# necessary software and R packages installed. If you are having any issues with
# this, please get in touch with me (sean@seananderson.ca) before the workshop.
# The following R code should walk you through it.
#
# I would suggest having the latest version of R, version 3.5.0.
# However, version 3.4 or above is probably fine.
# Check with:
sessionInfo()

# You can get the latest version at:
# https://cran.r-project.org/
#
# You will need to have the latest version of RStudio (1.1.447 or greater).
# You can check with RStudio -> About RStudio on a Mac or Help -> About RStudio on Windows.
# You can get the latest version at:
# https://www.rstudio.com/products/rstudio/download/
# If you know some other text editor really well (e.g. Vim, Emacs, or Sublime
# Text) and would rather use that, that's fine too.
#
# Install the following packages:
install.packages(c("tidyverse", "rstan", "rstanarm", "brms", "rmarkdown",
  "manipulate", "shiny", "remotes", "usethis"),
  dependencies = TRUE)
remotes::install_github("seananderson/ggsidekick")
