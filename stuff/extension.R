# SOURCE WORD CLOUD - http://onertipaday.blogspot.com/2011/07/word-cloud-in-r.html
# TIME ZONE DATA - http://www.tellingmachine.com/post/all-50-states-as-xml-json-csv-xls-files.aspx
#Load in necessary libraries
library(tm)
library(SnowballC)
library(wordcloud)
library(RColorBrewer)
library(stringr)

load("tweetsDFTexas.rda") # 1304 tweets
#load("tweetsDF.rda")  # 1.5 million tweets


#Get a sample from half of the original tweets data frame
#tweetsDF = tweetsDF[sample(nrow(tweetsDF), 700000), ]


#gmt offset
States <- read.csv("States.csv")

#Create data frame of States and their Time zones
States$GmtOffset =  str_extract(States$time.zone.1,"-[0-9]+")
States$GmtOffset =  as.numeric(States$GmtOffset)
States = data.frame(States$name,States$GmtOffset)
colnames(States) = c("state","GmtOffset")
States$state = tolower(States$state)

tweetsDF$tim = strptime(tweetsDF$tim,format="%Y-%m-%d %H:%M:%S",tz = "GMT")

tweetsDF = merge(tweetsDF,States,all.x=TRUE,sort =FALSE)
tweetsDF$localTime = tweetsDF$tim + tweetsDF$GmtOffset*3600 
tweetsDF$localTime = strptime(tweetsDF$localTime,format="%Y-%m-%d %H:%M:%S",tz = "GMT")

#Natural Language Processing
#Create a corpus - text document object
corpus = Corpus(VectorSource(tweetsDF$txt))
corpus = tm_map(corpus, content_transformer(removePunctuation))
corpus = tm_map(corpus, content_transformer(tolower))
#Remove stop words
corpus = tm_map(corpus, removeWords, c("texas", "RT", stopwords("SMART")))

#Get stem words from the tweets
corpus = tm_map(corpus, stemDocument)
#Create a Document Term matrix object
frequencies = DocumentTermMatrix(corpus)
#Remove words that do not appear a lot in the matrix
sparse = removeSparseTerms(frequencies, 0.999)

#save(tweetsDF,file="tweetsDF.rda")

tweetsSparse = as.data.frame(as.matrix(sparse))
freq = apply(tweetsSparse,2,sum)
popularity = sort(freq,decreasing=TRUE)
words = col(tweetsSparse)

# Create a word cloud of most popular code

freqDF = data.frame(popularity)
table(freqDF$popularity)
pal2 <- brewer.pal(8,"Dark2")
#png("wordcloud_packages2.png", width=1280,height=800)
wordcloud(row.names(freqDF),freqDF$popularity, scale=c(8,.2),min.freq=3,
          max.words=Inf, random.order=FALSE, rot.per=.15, colors=pal2)
#dev.off()


# local hour of the day tweet sent out
tweetsSparse$HOUR = tweetsDF$localTime$hour


