library(RMongo)
library(RJSONIO)

mongo = mongoDbConnect('michelin')

numTopics = 100
numTweets = 1293375


require(wordcloud)
require(RColorBrewer)
pal <- brewer.pal(9,"BuGn")
pal1 <- pal[-(1:4)]
