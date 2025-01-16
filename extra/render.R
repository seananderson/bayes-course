files <- list.files(here::here(), pattern = "*.Rmd")
# dir.create("exercises", showWarnings = FALSE)
# remove_exercises <- function(x) {
#   f <- readLines(x)
#   i <- grep("```", f)[[1]] - 1
#   f <- c(f[seq(1, i)],
#     "```{r, include=FALSE, eval=TRUE}",
#     "knitr::opts_chunk$set(root.dir = '..')",
#     "```",
#     "",
#     f[seq(i+1, length(f))])
#   f_ex <- ifelse(grepl("# exercise", f), "# exercise", f)
#   f_ex <- ifelse(grepl("<!-- exercise -->", f_ex), "<!-- exercise -->", f_ex)
#   writeLines(as.character(f_ex), con = file.path("exercises", x))
# }
# purrr::walk(files, remove_exercises)

## knit all exercises (slow)
purrr::walk(files, rmarkdown::render, envir = new.env())

library(future)
plan(multisession)
furrr::future_walk(files, rmarkdown::render, envir = new.env(), .options = furrr::furrr_options(seed = TRUE))
plan(sequential)
