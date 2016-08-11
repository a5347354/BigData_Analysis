library(shiny)
library(dplyr) 
library(reshape)
library(plotly)

shinyServer(
  function(input, output) {
    
    #funcition
    data_filter <- function(){
      kwd = input$keyword
      #設定時間
      start_date = as.character(input$dates[1])
      end_date = as.character(input$dates[2])
      #設定範圍
      orders_selected = subset(orders, as.Date(orders$訂單成立時間) >= as.Date(start_date) & as.Date(orders$訂單成立時間) <= as.Date(end_date))
      if(kwd  == '' ||  is.na(kwd))
        orders_selected
      else
        #filter(appledaily,category %in% cs, grepl(kwd,content))
        orders_selected[grepl(kwd,orders_selected$商品資訊),]
    }

    
    
    #-----------------Input-----------------

    
    #需用事件eventReactive，才能呈現realtime、interactive
    hours_plotly = eventReactive(c(input$dates,input$keyword),{
      ordersTimes = as.character.Date(data_filter()$訂單成立時間) %>% as.POSIXct(., format="%Y-%m-%d %H:%M")
      ordersHours = format(ordersTimes, "%H") %>% as.numeric() %>% table()
      
      x = list(title = "點/小時")
      y = list(title = "訂單量")
      plot_ly(x = names(ordersHours),
              y = ordersHours,
              fill = "tozeroy",
              name = "shopee") %>% layout(yaxis = y, 
                                          xaxis = x , 
                                          title = "韓吉大仔")
    })
    
    #需用事件eventReactive，才能呈現realtime、interactive
    total_plotly = eventReactive(c(input$dates,input$keyword),{
      #取出兩欄資料-訂單成立時間以及訂單小計
      df = data.frame(訂單成立時間 = data_filter()$訂單成立時間,訂單小計 = data_filter()$訂單小計..TWD.)
      df$訂單成立時間 = as.character.Date(df$訂單成立時間) %>% as.POSIXct(., format="%Y-%m-%d")
      df$訂單小計 = as.numeric(df$訂單小計)
      ordersDate_counted = format(df$訂單成立時間, "%Y-%m-%d") %>% table()
      ordersMoney_groupby = df %>% group_by(訂單成立時間) %>% summarise(訂單小計 = sum(訂單小計,na.rm=TRUE))
      
      x = list(title = "Time")
      y = list(title = "訂單量")
      plot_ly(x = names(table(ordersMoney_groupby[,1])), 
              y = ordersDate_counted, 
              #text = paste("Clarity:", clarity),
              mode = "markers", 
              #color = categories, 
              size = as.numeric(names(table(ordersMoney_groupby[,2])))) %>% layout(yaxis = y,
                                       xaxis = x,
                                       title = "韓吉大仔")
    })
    
    
    
    #表格Table
    delt_orders = reactive({
      data_filter()
    })
    
    
    
    
    #-----------------Output-----------------
    #表格Table
    output$itemtable <- 
      renderTable({ 
        delt_orders()
      })
    
    output$plotly_rect <- renderPlotly({
        hours_plotly()
    })
    
    output$plotly_markers  <- renderPlotly({
        total_plotly()
    })
    
    
  }
)

