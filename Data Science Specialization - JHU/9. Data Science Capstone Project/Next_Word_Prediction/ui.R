library(shiny)
library(markdown)

shinyUI(navbarPage("Next Word Prediction App",
                   
                   tabPanel("Word Prediction",
                            sidebarLayout(
                                sidebarPanel(
                                    textInput('Text', label = h3("Enter your text here:"), value = )
                                ),
                                
                                mainPanel(
                                    h3('Predicted next word:'), textOutput('next_word')
                                )
                            )),
                   
                   tabPanel("Documentation",
                            mainPanel(
                                includeMarkdown("README.md")
                            ))
))
