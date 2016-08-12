library(plotly)
library(shiny)
shinyUI(
  fluidPage( 
    #第一層
    titlePanel("Shopee Anaysis"),
    
    #第二層
    fluidRow(
      splitLayout(cellWidths = c("30%","70%"),
        wellPanel(
          h4('Filter:'), 
          checkboxGroupInput("categories",
                             "Category", 
                             categories,
                             selected = categories)
        ),
        wellPanel(
          h4('Keyword Volume:'), 
          br(), 
          textInput("keyword",
                     "Search", width='250px', placeholder="品客" ),
          htmlOutput("volume") 
        )
      )
    ),
    
    
    
    
    #第三層
    splitLayout(cellWidths = c("30%","70%"),
      dateRangeInput("dates", label = h3("Date range"),start = "2016-07-10"),
      
      
        # Tab標籤
        tabsetPanel(
          tabPanel("Summary",plotlyOutput("plotly_markers")), 
          tabPanel("各小時訂單分佈",plotlyOutput("plotly_rect")), 
          tabPanel("各產品銷量及銷售額",plotlyOutput("plotly_bar")),
          tabPanel("訂單", tableOutput("itemtable"))
        ) 
    
    )
  )
)