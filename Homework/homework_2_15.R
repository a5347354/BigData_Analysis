
# 請使用 R 語言分析一知名電商網站的商品購買記錄purchase.csv,希望能夠從記錄之中掌握使用者的行為與商品特性。
## 學員需要從網路上下載該電商的使用者購買紀錄 
## purchase <- read.csv(‘purchase.csv', header=TRUE)
## 學員需要找出用戶在每天哪個時段(0~24)會購買最多商品。
## 學員需要將每小時的購買紀錄繪製成折線圖(X軸為時段、Y軸為該時段購買 商品數量總和)。
## 學員需要找出購買金額排行前三名的使用者ID。
## 學員需要根據使用者購買金額,將前十名使用者的購買金額繪製成長條圖。 (X軸為使用者ID, Y 軸為購買金額),並將該長條圖由大到小做排列。

#-----https://rpubs.com/a5347354/198194-----

download.file('https://github.com/ywchiu/rtibame/raw/master/Data/purchase.csv', 'purchase.csv')
purchase <- read.csv('purchase.csv', header=TRUE)
View(purchase)
library(dplyr)

## 學員需要找出用戶在每天哪個時段(0~24)會購買最多商品。
purchaseTimes = purchase$Time %>% as.POSIXct(., format="%Y-%m-%d %H:%M:%S")
purchaseHours = format(purchaseTimes, "%H") %>% as.numeric() %>% table()
#修改margin
par(mar=c(1,1,1,1), mfrow = c(2,1))
purchaseHours[[1]][1]
barplot(purchaseHours)
## 學員需要將每小時的購買紀錄繪製成折線圖(X軸為時段、Y軸為該時段購買 商品數量總和)。

library(plotly)
x = list(title="時段")
y = list(title="購買量")
plot_ly(x = array(1:24), y = purchaseHours, fill = "tozeroy", name="taipei")  %>% layout(yaxis = y, xaxis = x , title = "UXXX電商")


## 學員需要找出購買金額排行前三名的使用者ID。
# 先做分組統計
purchaseSum = purchase %>% group_by(User) %>% summarise(view_sum = sum(Price, na.rm=TRUE)) %>% arrange(view_sum)
# 排序並取出前三
top3 = purchaseSum[order(purchaseSum$view_sum,decreasing = TRUE),] %>% head(.,3)
top3

## 學員需要根據使用者購買金額,將前十名使用者的購買金額繪製成長條圖。 (X軸為使用者ID, Y 軸為購買金額),並將該長條圖由大到小做排列。
top10 = purchaseSum[order(purchaseSum$view_sum,decreasing = TRUE),] %>% head(.,10)
names(top10)[names(top10)=="User"]= ""
top10
User = top10$User
Total = top10$view_sum
plot_ly(x = User, y = Total,type = "bar")  %>% layout(title = "前十名使用者購買金額")





