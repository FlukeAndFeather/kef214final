

#  Read in the data ------------------------------------------------------
library(tidyverse)
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
  filter(Sample_Date >= "1988-01-01" & Sample_Date <= "1994-12-31")
Bisley01_filtered

Bisley02_filtered <- Bisley02 |> 
  select(Sample_Date, K, Mg, Ca, `NO3-N`, `NH4-N`) |> 
  filter(Sample_Date >= "1988-01-01" & Sample_Date <= "1994-12-31")
Bisley02_filtered

Bisley03_filtered <- Bisley03 |> 
  select(Sample_Date, K, Mg, Ca, `NO3-N`, `NH4-N`) |> 
  filter(Sample_Date >= "1988-01-01" & Sample_Date <= "1994-12-31")
Bisley03_filtered

PuentoRoto_filtered <- PuentoRoto |> 
  select(Sample_Date, K, Mg, Ca, `NO3-N`, `NH4-N`) |> 
  filter(Sample_Date >= "1988-01-01" & Sample_Date <= "1994-12-31")
PuentoRoto_filtered

# Now we have three *pretty* datasets <3 
# Want to combine them all together 

Combined_Bisley_Data <- bind_rows(list(Bisley01_filtered, Bisley02_filtered, Bisley03_filtered, PuentoRoto_filtered))
Combined_Bisley_Data


#  Create averages -------------------------------------------------------

# Want to make 9 week moving averages for each ion 
# Need to filter the dates so it is for every 9 weeks 
# Need an empty column for site in the tibble 


Bisley_Averages <- tibble(
  window_start = seq(
    ymd("1988-01-05"),
    ymd("1994-12-27"),
    by = "9 weeks"
  ),
  K = NA,
  Mg = NA,
  Ca = NA,
  `NO3-N` = NA,
  `NH4-N` = NA
)
print(Bisley_Averages)


for (i in 1:nrow(Bisley_Averages)) {
  w1 <- Bisley_Averages$window_start[i] # what is the start of the window? call it w1
  w2 <- w1 + weeks(9) # create the end of the window, call it w2

  
print(w2)

  in_window <- filter(Bisley01_filtered, (Sample_Date >= w1 & Sample_Date < w2))

# Find the mean 

Bisley_Averages$K[i] <- mean(in_window$K, na.rm = TRUE)
Bisley_Averages$Mg[i] <- mean(in_window$Mg, na.rm = TRUE)
Bisley_Averages$Ca[i] <- mean(in_window$Ca, na.rm = TRUE)
Bisley_Averages$`NO3-N`[i] <- mean(in_window$`NO3-N`, na.rm = TRUE)
Bisley_Averages$`NH4-N`[i] <- mean(in_window$`NH4-N`, na.rm = TRUE)
}

#  pivot longer ----------------------------------------------------------

Bisley_Averages <- Bisley_Averages |> 
pivot_longer(cols = c(K, Mg, Ca, `NO3-N`, `NH4-N`), 
names_to = "Ions", 
values_to = "Concentrations"
)



# ggplot !  --------------------------------------------------------------

# Make line plot with just one file 

Bisley_Averages |> 
  ggplot(mapping = aes(x = window_start, y = Concentrations)) +
  geom_line() +
  facet_wrap(~Ions, scales = "free") +
  theme_minimal()


# Need to expand this and want to use pivot and facet wrap 
# We want the years on the x axis 
# want to use facet_wrap to get a chart of each ion?
  

