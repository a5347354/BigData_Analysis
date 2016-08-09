library(googleVis) 
library(dplyr) 
library(reshape)
library(plotly)

shinyServer(
  function(input, output) {

    #funcition
    data_filter <- function(kwd){
      if(kwd  == '' ||  is.na(kwd))
        order
      else
          #filter(appledaily,category %in% cs, grepl(kwd,content))
        order[grepl("品客",order$商品資訊),]
    }

    #Input 
    kwd <- reactive({
      input$keyword
    })

    delt_order = reactive({
      kwd <- kwd()
      data_filter(kwd)
    })
    
    # Output
    #表格Table
    output$itemtable <- 
      renderTable({ 
        delt_order()
      })
    
    
    
    
    
  }
)

