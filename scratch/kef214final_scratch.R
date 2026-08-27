
#  Read in the data ------------------------------------------------------

library(tidyverse)
source("R/moving-average.R")


Bisley01 <- read_csv("data/knb-lter-luq.20.4923064/QuebradaCuenca1-Bisley.csv")
Bisley02 <- read_csv("data/knb-lter-luq.20.4923064/QuebradaCuenca2-Bisley.csv")
Bisley03 <- read_csv("data/knb-lter-luq.20.4923064/QuebradaCuenca3-Bisley.csv")
PuentoRoto <- read_csv("data/knb-lter-luq.20.4923064/RioMameyesPuenteRoto.csv")
LTER <- read_csv("data/knb-lter-luq.20.4923064/LUQ LTER MDLs.csv")


# Filter Sample_Date so only rows 1988 to 1994 are included 
# create new data frame with only "Sample_Date", "K", "NO3-N", "Mg", "Ca", and "NH4-N"
# Want to filter each data set

Bisley01_filtered <- Bisley01 |> 
  select(Sample_Date, K, Mg, Ca, `NO3-N`, `NH4-N`) |> 
  filter(Sample_Date >= "1988-01-01" & Sample_Date <= "1994-12-31") |> 
  moving_average() |> 
  mutate(site = "BQ1")
Bisley01_filtered

Bisley02_filtered <- Bisley02 |> 
  select(Sample_Date, K, Mg, Ca, `NO3-N`, `NH4-N`) |> 
  filter(Sample_Date >= "1988-01-01" & Sample_Date <= "1994-12-31") |> 
  moving_average() |> 
  mutate(site = "BQ2")
Bisley02_filtered

Bisley03_filtered <- Bisley03 |> 
  select(Sample_Date, K, Mg, Ca, `NO3-N`, `NH4-N`) |> 
  filter(Sample_Date >= "1988-01-01" & Sample_Date <= "1994-12-31") |> 
  moving_average() |> 
  mutate(site = "BQ3")
Bisley03_filtered

PuentoRoto_filtered <- PuentoRoto |> 
  select(Sample_Date, K, Mg, Ca, `NO3-N`, `NH4-N`) |> 
  filter(Sample_Date >= "1988-01-01" & Sample_Date <= "1994-12-31") |> 
  moving_average() |> 
  mutate(site = "PR")
PuentoRoto_filtered

# Want to combine them all together 

Combined_Bisley_Data <- bind_rows(list(Bisley01_filtered, Bisley02_filtered, Bisley03_filtered, PuentoRoto_filtered))
Combined_Bisley_Data


# cleaned data csv  ------------------------------------------------------

# #  Create averages -------------------------------------------------------

## using the moving-average function 

#  pivot longer ----------------------------------------------------------

Bisley_Avgs <- Combined_Bisley_Data |> 
  pivot_longer(cols = c(k_mgl, mg_mgl, ca_mgl, no3n_mgl, nh4n_mgl),
names_to = "Ions", 
values_to = "Concentrations"
)


# ggplot !  --------------------------------------------------------------


# Make line plot with just one file 

Bisley_Avgs |> 
  ggplot(mapping = aes(x = window_start, y = Concentrations)) +
  geom_line() +
  facet_wrap(~Ions, scales = "free") +
  theme_minimal()

# Need to expand this and want to use pivot and facet wrap 
# We want the years on the x axis 
# want to use facet_wrap to get a chart of each ion?

