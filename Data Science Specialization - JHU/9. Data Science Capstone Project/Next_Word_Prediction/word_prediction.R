library(tm)
library(stringr)
library(stylo)

#Load n-grams
bi_grams <- readRDS('./ngrams/bigrams.rds')
tri_grams <- readRDS('./ngrams/trigrams.rds')
quad_grams <- readRDS('./ngrams/quadgrams.rds')

text_clean <- function(text){
    
    text_clean <- tolower(text)
    text_clean <- removePunctuation(text_clean)
    text_clean <- removeNumbers(text_clean)
    text_clean <- str_replace_all(text_clean, "[^[:alnum:]]", " ")
    text_clean <- stripWhitespace(text_clean)
    
    #Convert the input text string into a vector of words
    text_clean <- txt.to.words.ext(text_clean, 
                                  language="English.all", 
                                  preserve.case = TRUE)
    
    return(text_clean)
}


predict_next_word <- function(word_count, text){
    
    #If words count is equal or more than 3, take the last 3 words
    if (word_count >= 3) {
        text <- text[(word_count-2):word_count]
        
        #Predict first using quadgrams
        word_predict <- as.character(quad_grams[quad_grams$unigram==text[1] & 
                                                     quad_grams$bigram==text[2] & 
                                                     quad_grams$trigram==text[3],]
                                       [1,]$quadgram)
        
        #If no prediction, back-off to predict using trigrams
        if (is.na(word_predict)) {
            return (predict_next_word(2,text[2:3]))
        } 
    }
    
    #Predict using trigrams
    if (word_count == 2) {
        word_predict <- as.character(tri_grams[tri_grams$unigram==text[1] & 
                                                    tri_grams$bigram==text[2],]
                                       [1,]$trigram)
        
        #If no prediction, back-off to predict using bigrams
        if (is.na(word_predict)) {
            return (predict_next_word(1,text[3:3]))
        }
    }
    
    #Predict using bigrams
    if (word_count == 1) {
        word_predict <- as.character(bi_grams[bi_grams$unigram==text[1],]
                                       [1,]$bigram)
    }
    
    if (word_count == 0) {
        word_predict <- NA
    }
    
    print(word_predict)
    
}