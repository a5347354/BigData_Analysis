#人氣最夯
#抓取資料
library(jsonlite)
datas_menu = function (data_count){
  data_count = (data_count - 20) / 20 *50  
  i = 0
  while( i < data_count ){
    tag = "sales"
    url = paste0("http://mall.shopee.tw/search/api/items/?page_type=search&match_id=2209&keyword=%E9%80%B2%E5%8F%A3%E9%9B%B6%E9%A3%9F&shop_categoryids=&hashtag=&facet_type=&by=",tag,"&order=desc&newest=",i,"&limit=20&need_drop_word=false")
    menu = fromJSON(url)
    items = menu$items[c('name','price','stock','rating_good','liked_count','rating_star')]
    items = items 
    if(i == 0){
      i = i + 20
      old_items = items
    }
    else{
      i = i + 50
      old_items = rbind(old_items,items)
    }
  }
  return(old_items)
}

data_count = 20
tag = "sales"
url = paste0("http://mall.shopee.tw/search/api/items/?page_type=search&match_id=2209&keyword=%E9%80%B2%E5%8F%A3%E9%9B%B6%E9%A3%9F&shop_categoryids=&hashtag=&facet_type=&by=",tag,"&order=desc&newest=",data_count,"&limit=20&need_drop_word=false")
menu = fromJSON(url)
menu2 = fromJSON(url)

#資料處理
# menu$items
# name 商品名稱
# price / 100000 價錢
# rating_good 評價
# liked_count 讚數
# rating_star 廠商評價
# stock 存貨
items = menu$items[c('name','price','stock','rating_good','liked_count','rating_star')] 
items$price = as.character(items$price)
items2 = menu2$items[c('name','price','stock','rating_good','liked_count','rating_star')] 
items2$price = as.character(items2$price)

items = rbind(items,items2)
items$price = as.numeric(items$price) / 100000

View(items[grepl('小雞麵',items$name),])
