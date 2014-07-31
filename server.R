library(shiny)

shinyServer(function(input, output) {

  getWord <- function(wordIdx) {
    word = dbGetQuery(mongo, 'vocab', paste('{"_id":', wordIdx, '}'))$word
  }
  
  topic <- reactive({
    topic = dbGetQuery(mongo, 'topics', paste('{"topic":', input$ipTopic, '}'))
    words = fromJSON(topic$words)
    wordIdx = sapply(words, function(x) x[1])
    weights = sapply(words, function(x) x[2])

    wordValues = sapply(head(wordIdx, n = input$numWords), getWord)

    data.frame(word = wordValues,
               weight = head(weights, n = input$numWords),
              stringsAsFactors = FALSE)
  })

  tweet <- reactive({
     tweet = dbGetQuery(mongo, 'tweets', paste('{"tweetid":', input$ipTweet, '}'))
     tweetIdx = as.character(tweet$tweet)
     cat("Looking up ", tweetIdx, "\n")
     tweettext = dbGetQuery(mongo, 'tweettext', paste('{"tweet":', tweetIdx, '}'))
     #data.frame(screen_name = tweettext$screen_name, text = tweettext$text)
     tweettext
  })

  urls <- reactive({
     dbGetQuery(mongo, 'urls', paste('{"tweetid":', input$ipTweet, '}'))$url
  })
  
#   docs <- reactive({
#     docs <- predictions[, input$ipTopic, with=FALSE]
#     myname = colnames(docs)
#     head(sort(decreasing))
#   })
   
  output$topWords <- renderTable({
    topic()
  })
  
  output$topicWordcloud <- renderPlot({
    topic <- topic()
    # Show wordcloud for the topic
    wordcloud(topic$word, nrow(topic):1, c(8,.5),2,,TRUE,,.15,
              pal1,)
  })

  output$tweet <- renderText({
    tweet()$text
  })

  output$urls <- renderText({
    urls()
  })

  output$tweetTopics <- renderTable({
    tweet()
  })
    
})

