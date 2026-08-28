
#  Read in the data ------------------------------------------------------

library(tidyverse)
source("R/moving-average.R")
source("R/clean_data.R")

#  pivot longer ----------------------------------------------------------

Bisley_Avgs <- Combined_Bisley_Data |> 
  pivot_longer(cols = c(k_mgl, mg_mgl, ca_mgl, no3n_mgl, nh4n_mgl),
  names_to = "Ions", 
  values_to = "Concentrations",
)
# ggplot  --------------------------------------------------------------

Bisley_Avgs |> 
  ggplot(mapping = aes(
    x = window_start,
    y = Concentrations,
    colour = site,
    group = site,
    linetype = site
)) +
  theme_bw() +
  geom_line() +
  facet_wrap(~Ions, scales = "free", ncol = 1)



