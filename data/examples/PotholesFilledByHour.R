library(lubridate)
library(dplyr)
library(ggplot2)
potholes <- read.csv("https://cityofsyracuse.github.io/RoadsChallenge/data/potholes.csv", stringsAsFactors = FALSE)
potholes <- mutate(potholes, hour = hour(dtTime))

potholesByHour <- potholes %>% group_by(hour) %>% tally() %>% data.frame()

ggplot(potholesByHour, aes(hour, n)) +
  geom_bar(stat="identity") +
  theme_bw() +
  labs(title = "Potholes Filled By Hour",
       x = "Hour", 
       y = "Number of potholes filled") +
  scale_x_continuous(breaks = c(4:20))
