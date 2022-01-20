Untitled
================

# 1. Calculating Area per Barangay

The Area per barangay was identified by dividing the area of each region
with the number of barangays per region.

    for(region in regionarea$Area){
      #calculating area per brgy of all regions
      brgyarea = regionarea$Area[i] / sum(pop$Region == regionarea$Region[i])
      #print(brgyarea)
      
      # a = sum(pop$Region == "NATIONAL CAPITAL REGION")
      # print(a)

## 2.Calculating Barangay Density per Region

The Barangay density per region was calculated by dividing the barangay
populations with the area of each barangay

    #calculating brgy density per region
      popdf = data.frame(pop)
      #popdf_desc = arrange(popdf, -Population)
      brgy = subset(popdf, pop$Region == regionarea$Region[i])
      #brgydesc <- popdf[order(brgy$Population),]
      brgyPD = brgy$Population / brgyarea
      #print(brgyPD)

## 3. Identifying top 5 barangays with highest densities

To identify the top 5 barangays with highest densities, the sort
function was used.

     #top5 = arrange(regionarea, -Area)
      #print(brgyPD)
      #print(top_n(brgyPD,5))
      print( head(sort(brgyPD, decreasing=TRUE), n=5) )
      top5 = head(sort(brgyPD, decreasing=TRUE), n=5)
      
      write.table(top5, "brgyPD.csv", append = TRUE, row.names = FALSE)
      i = i+1
      
    }
