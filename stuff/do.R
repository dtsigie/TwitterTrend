#------------------------------------------------------------------------------
#  Author:                Thao Nguyen - Dawit Tsigie
#  Written:               1/23/2015
#  Last modified:         1/23/2015
#
#  Measure sentiment on Texas for every US state and create a sentiment heatmap
#  on the US map
#------------------------------------------------------------------------------

source("func.R")
load("tweetsDF.rdata")
#install.packages("maps")
library(maps)

#Add a State column to the data frame
state <- map.where("state",tweetsDF$lon, tweetsDF$lat)
tweetsDF$state <- gsub(":.*","", state)

#Assign sentiment to each tweets
tweetSent <- sapply(tweetsDF$txt, analyzeSentiment)
names(tweetSent) <- NULL
tweetsDF$sentiment <- tweetSent

#Create a State-sentiment Data frame
states <- c("alabama","arizona","arkansas","california",
           "colorado","connecticut","delaware","district of columbia",
           "florida","georgia","idaho","illinois",
           "indiana","iowa","kansas","kentucky",
           "louisiana","maine","maryland","massachusetts",
           "michigan","minnesota","mississippi","missouri",
           "montana","nebraska","nevada","new hampshire",
           "new jersey","new mexico","new york","north carolina",
           "north dakota","ohio","oklahoma","oregon",
           "pennsylvania","rhode island","south carolina","south dakota",
           "tennessee","texas","utah","vermont",
           "virginia","washington","west virginia","wisconsin",
           "wyoming")
sent <- sapply(states, avgSentiment)
stateSentiments <- data.frame(region = states, sentiment = sent)

###Create a sentiment map
#install.packages("ggplot2")

#Get the map data
library(ggplot2)
us_state_map <- map_data("state")

#Color each state according to its sentiment
us_state_map <- merge(us_state_map, stateSentiments, by="region", all=T)
map <- (qplot(long, lat, data=us_state_map, geom="polygon", group=group, fill=sentiment)
        + theme_bw() + labs(title="Twitter Trends", x="Longitude", y="Latitude", fill="Sentiment")
        + scale_fill_gradient2()
        + theme(legend.position="bottom", legend.direction="horizontal"))
#ggsave(file="texas.png", width=6, height=4)


