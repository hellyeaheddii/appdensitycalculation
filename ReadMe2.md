Calculating City Density
================

\#Calculating City Density

Assumption: All cities in a particular region will have equal land area

\#\#1. Aggregate of population per city

    popCityProv = aggregate(pop$Population, by=list(CityProvince=pop$CityProvince), FUN=sum)
    popByCity <- select(.data = pop, Region, CityProvince)

\#\#2. Count the CityProvice per region

    regCityProv = count(popByCity_unique, Region)

## 3. Combine Region, CityProvince, city count per region (n), total population per CityProvince

    popCity_count = merge(x=popByCity_unique,y=regCityProv,by =c("Region"),all.x = TRUE)
    popuByCity = merge(x=popCity_count,y=popCityProv,by =c("CityProvince"),all.x = TRUE)

## 4. Combine dataframe with region\_area

    city_area = merge(x=popuByCity,y=regionarea,by =c("Region"),all.x = TRUE)

\#\#5. Calculate density by city

    city_area$City_Area = city_area$Area / city_area$n

\#\#6. compute population density

    city_area$Population_Density = city_area$x / city_area$City_Area

\#\#7. dataframe with only CityProvince and population density columns

    CityProv_df <- select(.data = city_area, CityProvince, Population_Density)

\#\#8. get the top 5 city with highest density

    top5_city <- head(arrange(CityProv_df,desc(Population_Density)), n = 5)

\#\#9. export top\_city to csv

    write.csv(top5_city,"top5_city.csv", row.names = FALSE)
