library(dplyr)
library(ggplot2)
potholes <- read.csv("potholes.csv", stringsAsFactors = FALSE)
head(potholes)

RoadRatings2015 <- read.csv("./data/roads/RoadRatings2015.csv", stringsAsFactors = FALSE)
head(RoadRatings2015)
medianRating <- RoadRatings2015 %>% group_by(streetType) %>% summarise(mean = mean(overall, na.rm=TRUE), median = median(overall, na.rm=TRUE)) %>% data.frame()

medianRating.plot <- ggplot(medianRating, aes(streetType, median)) +
  geom_bar(stat="identity", fill = "blue") +
  theme_bw() +
  labs(title = "Median Rating by Street Type",
       x = "Street Type",
       y = "Median Rating")
ggsave("medianRating.jpg", medianRating.plot)
