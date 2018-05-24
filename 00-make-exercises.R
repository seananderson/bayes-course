files <- list.files(".", pattern = "*.Rmd")
dir.create("original-files", showWarnings = FALSE)
remove_exercises <- function(x) {
  file.copy(x, "original-files")
  f <- readLines(x)
  f_ex <- ifelse(grepl("# exercise", f), "# exercise", f)
  f_ex <- ifelse(grepl("<!-- exercise -->", f_ex), "<!-- exercise -->", f_ex)
  writeLines(as.character(f_ex), con = x)
}
purrr::walk(files, remove_exercises)

# purrr::walk(files, rmarkdown::render)
