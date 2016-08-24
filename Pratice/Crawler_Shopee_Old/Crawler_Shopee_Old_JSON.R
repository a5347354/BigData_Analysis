#-------------熱銷商品_Crawler---------------
#抓取資料
library(jsonlite)
datas_menu = function (data_count){
  data_count = (data_count - 50)
  i = 0
  while( i < data_count ){
    #tag = sales 最熱銷
    #tag = pop 人氣最夯
    #tag = ctime 最新
    #tag = price 價錢
    tag = "sales"
    # url = paste0("http://mall.shopee.tw/search/api/items/?page_type=search&match_id=2209&keyword=%E9%80%B2%E5%8F%A3%E9%9B%B6%E9%A3%9F&shop_categoryids=&hashtag=&facet_type=&by=",tag,"&order=desc&newest=",i,"&limit=20&need_drop_word=false")
    url = paste0("https://shopee.tw/api/v1/search_items/?by=",tag,"&order=desc&keyword=%E9%80%B2%E5%8F%A3%E9%9B%B6%E9%A3%9F&categoryids=2209&newest=",i,"&limit=50&need_drop_word=false")
    url2 = "https://shopee.tw/search/?facet=%257B%252266%2522%253A%255B-1%252C2209%255D%257D&keyword=%E9%80%B2%E5%8F%A3%E9%9B%B6%E9%A3%9F&order=asc&page=4&sortBy=sales
    "
    menu = fromJSON(url)
    menu2 = fromJSON(url2)
    #資料處理
    # menu$items
    # name 商品名稱
    # price / 100000 價錢
    # rating_good 評價
    # liked_count 讚數
    # rating_star 廠商評價
    # stock 存貨
    items = menu$items[c('name','price','stock','rating_good','liked_count','rating_star'),]
    # items = items
    # 舊版
    # if(i == 0){
    #   i = i + 20
    #   old_items = items
    # }
    # else{
    #   i = i + 50
    #   old_items = rbind(old_items,items)
    # }
    if(i == 0){
      i = i + 50
      old_items = items
    }else{
      i = i + 50
      old_items = rbind(old_items,items)
    }
  }
  return(old_items)
}

#判斷檔案是否存在
if(!file.exists("marketPlace_items.csv")){
  #datas_menu(抓取資料筆數)
  items = datas_menu(1000)
  items$price = as.numeric(items$price) / 100000
  write.csv(items,file = "marketPlace_items.csv")
}else{
  items = read.csv("marketPlace_items.csv")
  items = items[,-1]
}

items = items[order(items$price,decreasing = TRUE),]

# View(items[grepl('小雞麵',items$name),])

