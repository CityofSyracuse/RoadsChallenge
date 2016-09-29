library(rgdal)
library(RColorBrewer)

shapeData <- readOGR("S:/Data Research/Open Data/RoadsChallenge/data/street_shapefile",'streets')
shapeData <- spTransform(shapeData, CRS("+proj=longlat +ellps=GRS80"))
Ratings2000 <- read.csv("S:/Data Research/Open Data/RoadsChallenge/data/roads/RoadRatings2000.csv", stringsAsFactors = FALSE)


shapeData@data <- merge(shapeData@data, Ratings2000, by.x = "STREET_ID", by.y = "streetID")

shapeData@data$overall <- as.numeric(shapeData@data$overall)
shapeData@data$status <- "fair"
shapeData@data$status[shapeData@data$overall >7] <- "good" 
shapeData@data$status[shapeData@data$overall < 6] <- "poor" 
shapeData@data$status <- as.factor(shapeData@data$status)

plot(shapeData, col = c("yellow", "green","red")[shapeData@data$status], lwd = 2, main = "2000 Road Ratings")

