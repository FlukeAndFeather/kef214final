# Project Overview 
The goal for this final project is to recreate figure 3 from the [Scaefer et. al (2000)] paper. (https://doi.org/10.1017/s0266467400001358). 

![](fig3_schaefer.png)

This figure displays the change of concentrations for five different ions, being potassium (K), magnesium (Mg), calcium (Ca), nitrate (NO3-N), and ammonium (NH4-N), before and after Hurricane Hugo. This type of analysis is important because it helps to demonstrate how natural diasters can quickly alter ecosystems nutrient concentrations. 

# Data 
The following csv files, each containing data for a watershed site in Puerto Rico, are being used for this visualization. These files contain information we need including the date and ion, which will be further filtered and cleaned for our analysis. 
This data is sourced from the following: (https://doi.org/10.1017/s0266467400001358). 

csv files: 
1. QuebradaCuenca1-Bisley.csv 
2. QuebradaCuenca2-Bisley.csv
3. QuebradaCuenca3-Bisley.csv
4. RioMameyesPuenteRoto.csv


# Filtering Data 
 The above datasets were filtered to include six columns being the **Sample Date**, and the ions we are trying to learn more about, including **K, Mg, Ca, NO3-N, and NH4-N**. The Sample_Date column was filtered to select dates ranging from January 1, 1988 to January 1, 1994. Dates are going to be in a year, month, day (ymd) format in each file. Cleaned data can be found in the clean_data.R folder.

# Finding the Averages  
A moving average was created in order to to find the mean for every 9 week interval from the start date, and this was applied to each site in the clean_data.R function. The moving average function can be found here: (../R/moving-average.R)


# Creating the figures
The final figure recreates many elements of the original Figure 3 in the Schaefer paper. It displays time on the x axis, concentration on the y axis, and a legend for the sites. The ggplot package was used to create the figure in our analysis, allowing us to define and label the x and y axis, to generate line graphs, and to display multiple sites on one graph. 


# References 
- Schaefer DouglasA, McDowell WH, Scatena FN, Asbury CE. Effects of hurricane disturbance on stream water concentrations and fluxes in eight tropical forest watersheds of the Luquillo Experimental Forest, Puerto Rico. Journal of Tropical Ecology. 2000;16(2):189-207. doi:10.1017/S0266467400001358
