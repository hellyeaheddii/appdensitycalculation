Barangay Density
================
me
January 20, 2022

# Calculating Barangay Density

\#\#1. Load Packages

    library(tidyverse)
    library(reshape2)

    pop <- read.csv("population.csv", stringsAsFactors = TRUE)
    region_area <- read.csv("regionarea.csv", stringsAsFactors = TRUE)
    # head(pop)
    # head(region_area)

\#\#2 Finding the number of Barangays per Region

    region <- count(pop, Region)
    population <- merge(pop,region)
    pop_new <- merge(population,region_area)

\#\#3 Calculate Barangay Area

    pop_new$brgy_area <- pop_new$Area / pop_new$n

\#\#4 Calculate Population per Barangay Area

    pop_new$brgy_density <- pop_new$Population / pop_new$brgy_area

\#\#5 create a new dataframe with only ‘Barangay’ and ‘brgy\_density’

    brgy_df <- select(.data = pop_new,Barangay,brgy_density)

\#\#6 Extract only Top 5 barangays in PH in descending order

    top5brgy <- head(arrange(brgy_df,desc(brgy_density)), n = 5)
    write.csv(top5brgy,"top5brgy_PH.csv", row.names = FALSE)

\#\#7\#Extract only Top 5 per City in terms of population density

    top5brgy_perCity <- pop_new %>%
      arrange(desc(brgy_density)) %>% 
      group_by(CityProvince) %>%
      slice(1:5)
    top5brgy_perCity

    top5brgy_perCity <- select(.data = top5brgy_perCity,CityProvince,Barangay,brgy_density)

    write.csv(top5brgy_perCity,"top5brgy_perCity.csv", row.names = FALSE)

\#\#8 Extract only Top 5 per Region in terms of population density

    top5brgy_perRegion <- pop_new %>%
      arrange(desc(brgy_density)) %>% 
      group_by(Region) %>%
      slice(1:5)
    top5brgy_perRegion

    top5brgy_perRegion <- select(.data = top5brgy_perRegion,Region,Barangay,brgy_density)

\#\#9 Write CSV files

    write.csv(top5brgy_perRegion,"top5brgy_perRegion.csv", row.names = FALSE)
