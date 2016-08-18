library(rvest)
orders = read.csv("korean10146.shopee-order.csv")
orders = orders[,-c(1,2,3,4,11,12,13,17)]
as.character.Date(orders$訂單成立時間)
#排序
orders = orders[order(orders$訂單成立時間),]
#取出寄送方式當作類別
categories = unique(orders$寄送方式) %>% as.vector()
#產品
products = c("養樂多軟糖",
             "怪獸",
             "香脆點心麵",
             "火雞辣拌麵",
             "Enaak",
             "農心炸醬麵",
             "迷你香蕉巧克力棒",
             "預感洋芋片",
             "檸檬片",
             "黑旋風巧克力棒",
             "香蕉巧克力派") 


#-------------熱銷商品_Crawler---------------
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


#資料處理
# menu$items
# name 商品名稱
# price / 100000 價錢
# rating_good 評價
# liked_count 讚數
# rating_star 廠商評價
# stock 存貨
#datas_menu(抓取資料筆數)

items = datas_menu(200)
items$price = as.numeric(items$price) / 100000

# View(items[grepl('小雞麵',items$name),])

