library(rgdal)
library(raster)
library(dplyr)
library(stringr)
library(GISTools)

url <- "https://cityofsyracuse.github.io/RoadsChallenge/data/potholes.csv"
potholes <- read.csv(url, stringsAsFactors = FALSE)
head(potholes)
censusBlocks <- readOGR(".",'block_groups_2010_city')
censusBlocks <- spTransform(censusBlocks, CRS("+proj=longlat +datum=WGS84 +ellps=GRS80 +towgs84=0,0,0"))
head(potholes)
head(streetspotholes)

points <- potholes[,c("Longitude", "Latitude")]
spdf <- SpatialPointsDataFrame(coords = points, data = potholes,
                               proj4string = CRS("+proj=longlat +datum=WGS84 +ellps=GRS80 +towgs84=0,0,0"))

n.censusblocks <- poly.counts(spdf, censusBlocks)
shades = auto.shading(n.censusblocks,cols=brewer.pal(5,'Blues'))
PotholesByCensusBlockGroup <- choropleth(censusBlocks, n.censusblocks/poly.areas(censusBlocks), shading=auto.shading(n.censusblocks/poly.areas(censusBlocks)))

