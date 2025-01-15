library(dplyr)
library(ggplot2)

spp <- gfsynopsis::get_spp_names()
rock <- spp |>
  filter(grepl("rock", species_common_name))

out <- list()
for (i in seq_len(nrow(rock))) {
  print(rock[i, ])
  d0 <- readRDS(paste0("../gfsynopsis-2023/report/data-cache-2024-05/", rock[i, "spp_w_hyphens"], ".rds"))$survey_sets
  d <- filter(d0, survey_abbrev %in% c("SYN WCVI"), depth_m < 700, year != 2020, year != 2007)
  d <- filter(d, density_kgpm2 > 0)
  out[[i]] <- select(d, species_common_name, year, density_kgpm2, depth_m)
}
dat <- bind_rows(out)

set.seed(1)
dat <- group_by(dat, species_common_name) |>
  sample_frac(0.33)


ggplot(dat, aes(log(depth_m), log(density_kgpm2))) +
  geom_point() +
  facet_wrap(~species_common_name) +
  geom_smooth(se = FALSE)

dat <- group_by(dat, species_common_name) |>
  mutate(n = n()) |>
  filter(n > 100)

d <- dat
saveRDS(dat, file = "data/rockfish-depth.rds")
