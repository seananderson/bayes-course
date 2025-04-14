files <- list.files(".", pattern = "*.Rmd|*.R")

dir.create("exercise-files", showWarnings = FALSE)
remove_exercises <- function(x) {
  file.copy(x, "exercise-files")
  f <- readLines(x)
  f_ex <- ifelse(grepl("# exercise", f), "# exercise", f)
  f_ex <- ifelse(grepl("<!-- exercise -->", f_ex), "<!-- exercise -->", f_ex)
  f_ex <- ifelse(grepl("^Answer: ", f_ex), "Answer: ", f_ex)
  writeLines(as.character(f_ex), con = file.path("exercise-files", x))
}
purrr::walk(files, remove_exercises)
