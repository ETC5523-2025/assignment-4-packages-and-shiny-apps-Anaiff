
<!-- README.md is generated from README.Rmd. Please edit that file -->

# ausbushfire

<!-- badges: start -->

<!-- badges: end -->

The goal of ausbushfire is to help analyze the impacts of climate change
on bushfires in Australia using Fire Weather Index(FWI). It provides
tidy data and includes an app to visualize it.

The dataset includes annual ERA5 averages of soil moisture providing by
KNMI for the region of New South Wales, Australia.

## Installation

You can install the development version of ausbushfire from
[GitHub](https://github.com/ETC5523-2025/assignment-4-packages-and-shiny-apps-Anaiff)
with:

``` r
install.packages("remotes")
remotes::install_github("ETC5523-2025/assignment-4-packages-and-shiny-apps-Anaiff")
```

## Example

This is a basic example which shows you how to get the data:

``` r
library(ausbushfire)
# load data
data <- ausbushfire::fwi_data
```

This is an example which shows you how to use shiny app:

``` r
library(ausbushfire)
# Use shiny app
run_fwi_dashboard()
```
