
#  Read in the data ------------------------------------------------------

library(tidyverse)
source("R/moving-average.R")
source("clean_data.R")

#  pivot longer ----------------------------------------------------------

Combined_Avgs <- Combined_Data |> 
  pivot_longer(cols = c(k_mgl, mg_mgl, ca_mgl, no3_mgl, nh4_mgl),
  names_to = "Ions", 
  values_to = "Concentrations",
)
# ggplot  --------------------------------------------------------------

Combined_Avgs |> 
  rename(Years = window_start) |> 
  ggplot(mapping = aes(
    x = Years,
    y = Concentrations,
    colour = site,
    group = site,
    linetype = site
)) +
  theme_bw() +
  geom_line(color = "black") +
  facet_wrap(~Ions, scales = "free", ncol = 1)


