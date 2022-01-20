library(reshape2)
library(tidyverse)

# import data csv files
pop = read.csv("population.csv")
regionarea = read.csv("regionarea.csv")

# aggregate of population per city
popCityProv = aggregate(pop$Population, by=list(CityProvince=pop$CityProvince), FUN=sum)
popByCity <- select(.data = pop, Region, CityProvince)

# select distinct cities
popByCity_unique = popByCity[!duplicated(popByCity), ]

# count the CityProvince per Region
regCityProv = count(popByCity_unique, Region)

# combine Region, CityProvince, city count per region (n), total population per CityProvince 
popCity_count = merge(x=popByCity_unique,y=regCityProv,by =c("Region"),all.x = TRUE)
popuByCity = merge(x=popCity_count,y=popCityProv,by =c("CityProvince"),all.x = TRUE)

# combine dataframe with region_area
city_area = merge(x=popuByCity,y=regionarea,by =c("Region"),all.x = TRUE)

#Calculate density by city
city_area$City_Area = city_area$Area / city_area$n

# compute population density
city_area$Population_Density = city_area$x / city_area$City_Area

# dataframe with only CityProvince and population density columns
CityProv_df <- select(.data = city_area, CityProvince, Population_Density)
# get the top 5 city with highest density
top5_city <- head(arrange(CityProv_df,desc(Population_Density)), n = 5)

# export top_city to csv
write.csv(top5_city,"top5_city.csv", row.names = FALSE)