#######################################
##### Create a Wordcloud and a FCM ####
#######################################


library(quanteda)
library(wordcloud)
library(quanteda.textplots)
library(quanteda.textstats)
library(ggplot2)


### Function to create a wordcloud

create_wordcloud <- function(my_corpus){
  
 
  
  tokens = tokens(my_corpus, remove_numbers = TRUE, 
                  remove_punct = TRUE, 
                  remove_separators = TRUE)
  seq = phrase(c("très bien", "s'il vous plaît", "s'il-vous-plaît",
                 "tout à fait", "vous avez raison", "tu as raison", 
                 "avec raison"))
  
  tokens <- tokens_compound(tokens, seq)
  # The french language use apostrophes which the function tokens() considers has one word
  tokens <- tokens_split(tokens, "'")
  
  my_dfm = dfm(tokens)
  
  
  ## I want to keep the most words as possible to have a true comparison 
  # of the language used between men and women
  my_stopwords = c(stopwords("fr"), "c'est", "ça", "a", "n'est",
                   "où", "quoi", "du", "L", "M", "La", 
                   "s", "qu", "ont", "d", "c", "m", "au")
  
  myStemMat = dfm(my_dfm) %>% dfm_remove(my_stopwords)
                  
  
  out <- topfeatures(myStemMat, 20)
  lexdiv = textstat_lexdiv(myStemMat)
  
  set.seed(101)
  
  textplot_wordcloud(myStemMat,
                     min_count = 5, 
                     random_order = FALSE,
                     rotation = .25, 
                     color = RColorBrewer::brewer.pal(8,"Dark2"))
  
  
  out
  
  ###### Feature co-occurence matrix
  fcm <- fcm(myStemMat)
  feat <- names(topfeatures(myStemMat, 50))
  fcmat_news_select <- fcm_select(fcm, pattern = feat, selection = "keep")
  dim(fcmat_news_select)
  
  
  size <- log(colSums(dfm_select(myStemMat, feat, selection = "keep")))
  
  set.seed(144)
  textplot_network(fcmat_news_select, min_freq = 0.8, vertex_size = size / max(size) * 3)
  
  
}

nb_words <- function(my_corpus){
  out = textstat_summary(my_corpus)[,4] %>% mean()
  out
}


#### Different datasets
interruption_men_women <- corpus(df$orateurs_texte_without[df$orateurs_interruption == "INTERRUPTION_1_10"
                                                 & df$gender == "M" 
                                                 & df$orateurs_qualite != "President assemblee"
                                                 & shift(df$gender) == "F"])

interruption_men_men <- corpus(df$orateurs_texte_without[df$orateurs_interruption == "INTERRUPTION_1_10"
                                                 & df$gender == "M" 
                                                 & df$orateurs_qualite != "President assemblee"
                                                 & shift(df$gender) == "M"])
textstat_summary(interruption_men)[,4] %>% mean()

interruption_women_women <- corpus(df$orateurs_texte_without[df$orateurs_interruption == "INTERRUPTION_1_10"
                                                 & df$gender == "F" 
                                                 & df$orateurs_qualite != "President assemblee"
                                                 & shift(df$gender) == "F"])

interruption_women_men <- corpus(df$orateurs_texte_without[df$orateurs_interruption == "INTERRUPTION_1_10"
                                                 & df$gender == "F" 
                                                 & df$orateurs_qualite != "President assemblee"
                                                 & shift(df$gender) == "M"])



create_wordcloud(interruption_men_women)
create_wordcloud(interruption_men_men)
create_wordcloud(interruption_women_women)
create_wordcloud(interruption_women_men)



