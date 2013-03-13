## Response to  
## http://r-ecology.blogspot.com/2011/12/weecology-can-has-new-mammal-dataset.html

## Code from R-ecology
# URLs for datasets
comm <- "http://esapubs.org/archive/ecol/E092/201/data/MCDB_communities.csv"
refs <- "http://esapubs.org/archive/ecol/E092/201/data/MCDB_references.csv"
sites <- "http://esapubs.org/archive/ecol/E092/201/data/MCDB_sites.csv"
spp <- "http://esapubs.org/archive/ecol/E092/201/data/MCDB_species.csv"
trap <- "http://esapubs.org/archive/ecol/E092/201/data/MCDB_trapping.csv"

# read them
require(plyr)
datasets <- llply(list(comm, refs, sites, spp, trap), read.csv, .progress='text')
str(datasets[[1]]); head(datasets[[1]]) # cool, worked
llply(datasets, head) # see head of all data.frame's

# Map the communities
require(ggplot2)
require(maps)
sitesdata <- datasets[[3]]
sitesdata <- sitesdata[!sitesdata$Latitude == 'NULL',]
sitesdata$Latitude <- as.numeric(as.character(sitesdata$Latitude))
sitesdata$Longitude <- as.numeric(as.character(sitesdata$Longitude))
sitesdata$Elevation_high <- as.numeric(as.character(sitesdata$Elevation_high))
sitesdata <- sitesdata[sitesdata$Longitude > -140,]

## Alternative plot with Google Vis. API
## Add a new column with lat-long coordinates merged
sitesdata$LatLong <- with(sitesdata, paste(Latitude, Longitude, sep=":"))
require(googleVis)
## display the data with interactive geo charts

world <- gvisGeoChart(sitesdata, "LatLong", colorvar="Elevation_high", sizevar="Elevation_low",
  		options=list(displayMode="markers", sizeAxis="{minValue: 0, maxSize: 10}", 
					 	 colorAxis="{minValue: 0, colors: ['#BDC9E1', '#045A8D']}", 
					 	 width=700, height=500), chartid="World")
plot(world)

us <- gvisGeoChart(sitesdata, "LatLong", colorvar="Elevation_high", sizevar="Elevation_low", 
			options=list(region="US",
						 displayMode="markers", sizeAxis="{minValue: 0, maxSize: 10}", 
					 	 colorAxis="{minValue: 0, colors: ['#BDC9E1', '#045A8D']}"),
					 	 chartid="US")
plot(us)
