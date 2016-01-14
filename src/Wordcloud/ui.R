library(shiny)

shinyUI(fluidPage(
  titlePanel("Word Clouds for Texas Tweets by Hour"),
  sidebarLayout(
    sidebarPanel(
      #Slide bar w/ input for the hour range
      sliderInput("hour","Select hour of the day:",
                  min=0, max=23,value=12)
    ),
    #Show word cloud
    mainPanel(
      plotOutput("wordCloud",width="1000px",height="1000px")
      )
  )
  ))
