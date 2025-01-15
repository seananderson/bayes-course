library(ggplot2)
library(dplyr)

d <- readRDS("../gfsynopsis-2023/report/data-cache-2024-05/pacific-cod.rds")$survey_samples
# d <- dplyr::filter(d, !is.na(length), !is.na(age)) |> select(length, age)
d <- dplyr::filter(d, !is.na(length), !is.na(age)) |>
  filter(survey_abbrev %in% c("SYN HS", "SYN WCVI")) |>
  select(length, age, survey = survey_abbrev)

set.seed(1)
d <- group_by(d, survey) |>
  sample_n(500)

saveRDS(d, "data/pcod-growth.rds")
