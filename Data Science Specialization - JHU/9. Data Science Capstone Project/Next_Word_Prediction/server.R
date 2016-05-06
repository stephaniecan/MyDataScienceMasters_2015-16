library(shiny)

source("./word_prediction.R")

shinyServer(function(input, output) {
    
    next_word <- reactive({
        text_input <- text_clean(input$Text)
        num_word <- length(text_input)
        
        # Predict the next word using the function in word_predictor.R
        next_word <- predict_next_word(num_word, text_input)
    })
    
    # Attach the predicted word to the next_word element in Shiny UI.
    output$next_word <- renderText(next_word())
    
})