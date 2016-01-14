                                               
#Twitter trends project




## Source Files: func.R, clean.R, do.R, twitterExtension.Rmd.
===============================================================
* scrape.R: example code to get data from Twitter's API - not needed for the rest of the project
* func.R: includes all functions required for data analysis
* clean.R: searches tweets collected from text file for "Texas" and puts data in an R data frame
* do.R: calculates sentiments on Texas for each state and creates a sentiment heat map
* extension.R: includes all the code required for our extension project 
* Wordcloud app: a folder consisting of the Shiny App to create our interactive word cloud
	ui.R: creates UI platform for the shiny app
	server.R: set up server to run and analyze data for the shiny app
	tweetsSparse.rda: data(700,000 tweets) to run the Wordcloud app- found in Wordcloud app
	tweetsSparseTexas.rda: data(1304 tweets) to run the Wordcloud app - found in Wordcloud app

* Twitter.rmd: R markdown file that explains and analyzes data from the extension project - requires tweetsDFTexas.rda to run. Shiny app has been embedded in the markdown
States.csv: state and time zone data
sentiments.csv: sentiment - word value


##  External resources                       
 ===================================================================
Natural Language Processing: from online course Analytics Edge - MIT 
https://courses.edx.org/courses/MITx/15.071x/1T2014/info

Word Cloud code: http://onertipaday.blogspot.com/2011/07/word-cloud-in-r.html

TIME ZONE DATA - http://www.tellingmachine.com/post/all-50-states-as-xml-json-csv-xls-files.aspx

## Issues 
=====================================================================
For the extension part we could not process the original tweet data because of memory limit.
Therefore, we sampled the data and only used 700000 of the tweets in our analysis.
Because of this big data set, our wordCloud Shiny app takes a lot of time to update.

We have only provided an analysis of the tweets about Texas because of the problem we encountered above.


 