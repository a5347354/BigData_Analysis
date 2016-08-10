shinyUI(
  fluidPage( 
    #第一層
    titlePanel("Shopee Anaysis"),
    
    #第二層
    fluidRow(
      column(8,
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
      dateRangeInput("dates", label = h3("Date range"),start = "2016-07-10"),
      
      
        # Tab標籤
        tabsetPanel(
          tabPanel("各小時訂單分佈",  plotlyOutput("plotly")), 
          tabPanel("Summary", verbatimTextOutput("summary")), 
          tabPanel("訂單", tableOutput("itemtable"))
        ) 
    
    )
  )
)