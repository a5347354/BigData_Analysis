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

