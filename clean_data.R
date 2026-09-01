
# Load in packages and functions -----------------------------------------

library(tidyverse) 
source("R/moving-average.R") 

# Read in data -----------------------------------------------------------

Bisley01 <- read_csv("data/knb-lter-data/QuebradaCuenca1-Bisley.csv")
Bisley02 <- read_csv("data/knb-lter-data/QuebradaCuenca2-Bisley.csv")
Bisley03 <- read_csv("data/knb-lter-data/QuebradaCuenca3-Bisley.csv")
PuentoRoto <- read_csv("data/knb-lter-data/RioMameyesPuenteRoto.csv")
LTER <- read_csv("data/knb-lter-data/LUQ LTER MDLs.csv")


# Filtering and applying our function to the data ------------------------
# filter Sample_Date so only rows 1988 to 1994 are included 
# only wnat columns "Sample_Date", "K", "NO3-N", "Mg", "Ca", and "NH4-N"
# apply the moving_average function to find the mean
# organize by each site 

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

# Combine data using bind_rows ------------------------------------------------

Combined_Data <- bind_rows(list(Bisley01_filtered, Bisley02_filtered, Bisley03_filtered, PuentoRoto_filtered))
Combined_Data


# Create a csv -----------------------------------------------------------

write.csv(Combined_Data, "fig3_data.csv", row.names = FALSE)

