library(shiny)
library(wordcloud)

 shinyServer(function(input,output){
  
   #Load Data frame
   load("tweetsSparse.rda")
   output$wordCloud <- renderPlot({
    
    #Subset the data by hour and create a frequency dataframe to plot the word cloud
   
    hourFreq = subset(tweetsSparse,HOUR == input$hour, select= -c(HOUR,amp))
    freq = apply(hourFreq,2,sum)
    popularity = sort(freq,decreasing=TRUE)
    freqDF = data.frame(popularity,hour=i)
    
    
    #Create a word cloud based on hour$HOUR
    pal2 <- brewer.pal(8,"Dark2")
    wordcloud(row.names(freqDF),freqDF$popularity, scale=c(8,.02),min.freq=1,
              max.words=Inf, random.order=FALSE, rot.per=.15, colors=pal2)
    
  })
})