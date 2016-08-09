order = read.csv("korean10146.shopee-order.csv")
order = order[,-c(1,2,4,11,12,13,17)]
as.character.Date(order$訂單成立時間)
#categories = unique(order$付款方式)

