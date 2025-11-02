## code to prepare `fwi_data` dataset goes here

fwi_data <- readr::read_csv("data-raw/era5_yearly_seasmax_nsw.csv")
msr_data <- readr::read_csv("data-raw/msr_yearly_seasmax_nsw.csv")
data <- dplyr::left_join(fwi_data, msr_data, by = "year")

usethis::use_data(data, overwrite = TRUE)


