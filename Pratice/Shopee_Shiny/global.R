orders = read.csv("korean10146.shopee-order.csv")
orders = orders[,-c(1,2,3,4,11,12,13,17)]
as.character.Date(orders$訂單成立時間)
#categories = unique(order$付款方式)

