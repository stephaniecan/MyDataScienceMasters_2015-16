fluidPage(
    # Application title
    titlePanel("Book Word Cloud"),
    
    sidebarLayout(
        # Sidebar with a slider and selection inputs
        sidebarPanel(
            selectInput("selection", "Choose your favorite book:",
                        choices = books),
            actionButton("update", "Change book"),
            hr(),
            sliderInput("freq",
                        "Minimum Frequency of Words:",
                        min = 1,  max = 50, value = 15),
            sliderInput("max",
                        "Maximum Number of Words:",
                        min = 1,  max = 300,  value = 80)
        ),
        
        # Show Word Cloud
        mainPanel(
            plotOutput("plot")
        )
    )
)
