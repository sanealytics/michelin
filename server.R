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
    
})

