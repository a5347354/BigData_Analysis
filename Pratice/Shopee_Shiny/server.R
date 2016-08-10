library(googleVis) 
library(dplyr) 
library(reshape)
library(plotly)

shinyServer(
  function(input, output) {

    #funcition
    data_filter <- function(kwd){
      #設定時間
      start_date = as.character(input$dates[1])
      end_date = as.character(input$dates[2])
      #設定範圍
      orders_selected = subset(orders, as.Date(orders$訂單成立時間) >= as.Date(start_date) & as.Date(orders$訂單成立時間) <= as.Date(end_date))
      sort(orders_selected,decreasing = TRUE)
      if(kwd  == '' ||  is.na(kwd))
        orders_selected
      else
        #filter(appledaily,category %in% cs, grepl(kwd,content))
        orders_selected[grepl(kwd,orders_selected$商品資訊),]
    }

    
    
    #Input 
    kwd <- reactive({
      input$keyword
    })

    delt_orders = reactive({
      kwd <- kwd()
      data_filter(kwd)
    })
    
    orders_selected = reactive({
      start_date = input$dates[1]
      end_date = input$dates[2]
  
    })
    
    hours_plotly = eventReactive(input$dates,{
      #設訂時間
      start_date = as.character(input$dates[1])
      end_date = as.character(input$dates[2])
      
      #設定時間日期，時間範圍
      orders_selected = subset(orders, as.Date(orders$訂單成立時間) >= as.Date(start_date) & as.Date(orders$訂單成立時間) <= as.Date(end_date))
      ordersTimes = as.character.Date(orders_selected$訂單成立時間) %>% as.POSIXct(., format="%Y-%m-%d %H:%M")
      ordersHours = format(ordersTimes, "%H") %>% as.numeric() %>% table()
      
      x = list(title = "小時")
      y = list(title = "訂單量")
      plot_ly(x = array(0:23),y = ordersHours,fill = "tozeroy",name = "shopee") %>% layout(yaxis = y, xaxis = x , title = "韓吉大仔")
    })
    
    
    # Output
    #表格Table
    output$itemtable <- 
      renderTable({ 
        delt_orders()
      })
    
    output$plotly <- renderPlotly({
        hours_plotly()
      
      })
    
    
    output$summary  <- renderText({
          as.character(input$dates[1])
    })
    
    
  }
)

