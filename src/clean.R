#------------------------------------------------------------------------------
#  Author:                Thao - Dawit
#  Written:               1/20/2014
#  Last modified:         1/20/2014
#
#  Loads tweets from text files, searches them for a key term, and saves those 
#  that match in a handy-dandy data frame written to an rdata file.
#------------------------------------------------------------------------------
library(stringr)

# read input from file   REMEMBER to change the path as necessary!
tweets <- readLines("tweets2014.txt")

# subset the data by keeping the tweets that match a query term
# YOUR SUBSET CODE GOES HERE
texas <- sapply(tweets, function(tweet) str_detect(tweet, ignore.case("Texas")))
tweets <- subset(tweets, texas)

# create a vector for each of the four variables
n <- length(tweets)
lat <- numeric(n)
lon <- numeric(n)
tim <- character(n)
txt <- character(n)

# extract the variables from each tweet
# YOUR PARSING CODE GOES HERE
#Extract Variables
for (i in 1:n) {
  tweet = unlist(str_split(tweets[i], "\t"))
  pos = unlist(str_split(gsub("\\[|\\]", "",tweet[1]), ","))
  lat[i] = as.numeric(pos[1])
  lon[i] = as.numeric(pos[2])
  tim[i] = tweet[3]
  txt[i] = tweet[4]
}

# build the data frame and write the output to file
tweetsDF <- data.frame(lat, lon, tim, txt, stringsAsFactors=FALSE)
save(tweetsDF, file = "tweetsDF.rdata")