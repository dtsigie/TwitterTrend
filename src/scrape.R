#------------------------------------------------------------------------------
#  Author:                Thao Nguyen - Dawit Tsigie
#  Written:               1/20/2015
#  Last modified:         1/20/2015
#
#  Get data from Twitter's API
#------------------------------------------------------------------------------

# install.packages("twitteR")
# install.packages("streamR")
library(twitteR)
library(ROAuth)



# Set SSL certs globally
options(RCurlOptions = list(cainfo = system.file("CurlSSL", "cacert.pem", package = "RCurl")))

consumerKey <- "JeUMpTJiX66FpCEXwsWzOSO1p"
consumerSecret <- "Q2uzvqDQX3rMPbwUSnxeQTXl1e5bZRH9FWC23J4upJ29pwdG5D"
reqURL <- "https://api.twitter.com/oauth/request_token"
accessURL <- "https://api.twitter.com/oauth/access_token"
authURL <- "http://api.twitter.com/oauth/authorize"
twitCred <- OAuthFactory$new(consumerKey=consumerKey,
                             consumerSecret=consumerSecret,
                             requestURL=reqURL,
                             accessURL=accessURL,
                             authURL=authURL)

twitCred$handshake()
save(twitCred, file = "credentials.RData")

###Scrape Past Tweets
load("credentials.RData")
registerTwitterOAuth(twitCred)
tweetList <- searchTwitter("texas", n = 50)
tweetDataFrame <- twListToDF(tweetList)

### Stream Live Tweets
library(streamR)
load("credentials.RData")

# Set SSL certs globally
options(RCurlOptions = list(cainfo = system.file("CurlSSL", "cacert.pem", package = "RCurl")))
filterStream(file.name="tweets_keyword.json", track=c("texas"), timeout=300, oauth=twitCred)
# parsing tweets into dataframe
tweets_texas <- parseTweets("tweets_keyword.json", verbose = TRUE)

