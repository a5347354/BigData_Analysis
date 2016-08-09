shinyUI(
  fluidPage( 
    #第一層
    titlePanel("Shopee Anaysis"),
    
    #第二層
    fluidRow(
      column(3,
            dateRangeInput("dates", label = h3("Date range"))
      ),column(8,
               wellPanel(
                 h4('Keyword Volume:'), 
                 br(), 
                 textInput("keyword",
                           "Search", width='250px', placeholder="品客" ),
                 htmlOutput("volume") )
      )
    ),
    
    
    #第三層
    splitLayout(cellWidths = c("30%","70%"),
      dateRangeInput("dates", label = h3("Date range")),
        # Tab標籤
        tabsetPanel(
          tabPanel("Plot", plotOutput("plot")), 
          tabPanel("Summary", verbatimTextOutput("summary")), 
          tabPanel("Table", tableOutput("itemtable"))
        ) 
    
    )
  )
)