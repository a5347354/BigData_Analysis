# RPubs : http://rpubs.com/a5347354/195541
library(rvest)
newsurl = 'http://news.ltn.com.tw/list/BreakingNews'
news = read_html(newsurl)
title = news %>% html_nodes(".picword") %>% html_text()
datetime = news %>% html_nodes(".lipic span") %>% html_text()
url = news %>% html_nodes(".picword") %>% html_attr("href")
tab = news %>% html_nodes(".lipic span") %>% html_attr("class")
tab
ltn_news = data.frame(title = title, datetime = datetime, url = url)
ltn_news
#抓取ＣＳＳ
css <-  read_html('http://news.ltn.com.tw/css/news/style.css?201509', encoding='UTF-8')

library(stringr)
#使用正規表達式
#.list span a.tab1:after{content:"焦點";}
#.list span a.tab2:after{content:"政治";}
map_table <- css   %>%  iconv(from='UTF-8', to='UTF-8') %>% str_match_all(pattern='.list span a.(.*?):after\\{content:"(.*?)";\\}', string =.)   
map_list = list()
map_list[map_table[[1]][,2]] = map_table[[1]][,3]
#category = sapply(category, function(e)map_list[e]) %>% unlist()
#ltn_news = data.frame(title = title, datetime = datetime, url = url, category = category)