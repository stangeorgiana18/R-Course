# compile docs
# featurize them
# compare their features

# install.packages('tm') # text manipulation
# install.packages('twitteR')
# install.packages('wordcloud')
# install.packages('RColorBrewer')
#install.packages('e1017')
#install.packages('class')

library(twitteR)
library(tm)
library(wordcloud)
library(RColorBrewer)

ckey <- "HY7uWYIkUs0DMgM8JqKrFQlSp"
skey <- "04qcW6WHm4c5EyVAgiYTnutAkO8PToQC1XnhNDr8VpuDOsVkj8"
token <- "1761097903613886464-lv29M0zlQDH8qn1trPynnZDy6aU6Ay"
sectoken <- "sS1eVgaRS3eRDVFaopBzHnsNEJ3iRW9b37M8Hv3rqauTg"

# CONNECT TO TWITTER
setup_twitter_oauth(ckey, skey, token, sectoken)

## Returning 1000 Tweets
soccer.tweets <- searchTwitter('soccer', n = 1000, lang = 'en')
##
## Grabbing Text Data from Tweets using an anonymous function
soccer.text <- sapply(soccer.tweets, function(x) x$getText())

####
# CLEAN THE TEXT DATA
####
# encoding function --> remove emoticons and characters that are not in utf-8
# this way we don't have errors in case there are weird symbols, accent marks etc.
soccer.text <- iconv(soccer.text, 'UTF-8', 'ASCII')
##
soccer.corpus <- Corpus(VectorSource((soccer.text))) # create a corpus
##
# DOCUMENT TERM MATRIX
## control -= list of operations we want to do
term.doc.matrix <- TermDocumentMatrix(soccer.corpus, control = list(removePunctuation = TRUE, 
                                      stopwords = c('soccer', stopwords('english')), removeNumbers = TRUE, 
                                      tolower = TRUE))
                                      
                                      
###
# Convert the object into a matrix
term.doc.matrix <- as.matrix(term.doc.matrix)

# GET WORD COUNTS
word.freqs <- sort(rowSums(term.doc.matrix), decreasing = T)
dm <- data.frame(word = names(word.freqs), freq = word.freqs) # create a df with all the words and their counts

# CREATE THE WORDCLOUD
wordcloud(dm$word, dm$freq, random.order = FALSE, colors = brewer.pal(8, 'Dark2'))



# didn't work out because of the changed access levels in X


