library(shiny)

shinyUI(fluidPage(theme = "superhero.min.css",
  
  # Application title
  headerPanel("Social transportation conversations"),
  
  # Sidebar with a slider input for number of observations
  sidebarPanel(
    sliderInput("ipTopic", 
                "Choose conversation:", 
                min = 1, 
                max = numTopics, step = 1,,
                format = "Conversion #", 
                value = 1, animate = animationOptions(interval = 2000, loop = TRUE)),
    
    sliderInput("ipTweet", 
                "Choose tweet:", 
                min = 1, 
                max = numTweets, step = 1,,
                format = "Tweet #", 
                value = 1, animate = animationOptions(interval = 2000, loop = TRUE)),
    
    sliderInput("numWords",
                "Number of words:", 
                min = 5, max = 20, 
                value = 10)
  ),
  
  # Show a plot of the generated distribution
  mainPanel(
    tabsetPanel(
      tabPanel("Conversations", plotOutput("topicWordcloud", width = 600, height = 600)),
      tabPanel("Raw data", tableOutput("topWords")),
      tabPanel("Tweet", textOutput("tweet"), tableOutput("tweetTopics"),
               h4("urls extracted"), textOutput('urls')),
      HTML('<footer>All rights reserved <a href = "mailto:saurabh.writes+whiskey@gmail.com?Subject=Social%20Transportation%20Conversations&Body=Hi%2C%0A%0AI%20saw%20your%20whiskey%20topic%20generator%20and%20I%20thought%20it%20was%20awesome%21%20Let%27s%20grab%20a%20drink.%0A%0A">Saurabh </a></footer>')  
    )
  )
))

