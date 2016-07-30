appleurl = 'http://www.appledaily.com.tw/realtimenews/article/entertainment/20160710/904877/伊能靜生女照被當廣告　坐月子還要忙告人'
h1 = read_html(appleurl) %>% html_nodes('#h1') %>% html_text() %>% iconv(from='UTF-8', to='UTF-8')
trans = read_html(appleurl) %>% html_nodes('.trans') %>% html_text() %>% iconv(from='UTF-8', to='UTF-8')
clicked = read_html(appleurl) %>% html_nodes('.clicked') %>% html_text() %>% iconv(from='UTF-8', to='UTF-8')
gggstime = read_html(appleurl) %>% html_nodes('.gggs time') %>% html_text() %>% iconv(from='UTF-8', to='UTF-8')


df = data.frame(title = h1, article = trans, click = clicked, dt = gggstime)
getArticle = function(appleurl, category){
  h1 = read_html(appleurl) %>% html_nodes('#h1') %>% html_text() %>% iconv(from='UTF-8', to='UTF-8')
  trans = read_html(appleurl) %>% html_nodes('.trans') %>% html_text() %>% iconv(from='UTF-8', to='UTF-8')
  clicked = read_html(appleurl) %>% html_nodes('.clicked') %>% html_text() %>% iconv(from='UTF-8', to='UTF-8')
  gggstime = read_html(appleurl) %>% html_nodes('.gggs time') %>% html_text() %>% iconv(from='UTF-8', to='UTF-8')
  
  df = data.frame(title = h1, article = trans, click = clicked, dt = gggstime, category = category)
  df
}


dfall = data.frame(title = character(), 
                   article= character(),
                   click = character(), 
                   dt =character(),
                   category= character())
getURL <- function(applenews){  
  applenews = 'http://www.appledaily.com.tw/realtimenews/section/new/'
  rtddt = read_html(applenews) %>% html_nodes('.rtddt a')
  for (ele in rtddt){
    categorys = ele %>% html_nodes('h2') %>% 
      html_text() %>% iconv(from='UTF-8', to='UTF-8')
    links = ele %>% html_attr('href') %>% 
      iconv(from='UTF-8', to='UTF-8')
    links = paste0('http://www.appledaily.com.tw', links)
    df = getArticle(links, categorys)
    dfall <- rbind(dfall,df)
    
  }
  dfall
}

newsall = getURL('http://www.appledaily.com.tw/realtimenews/section/new/')
View(newsall)

#判斷類別
class(newsall[ 1 , "article" ])
# 將factor 轉型回character
newsall$article = as.character(newsall$article)
# write in magrittr %>%
strsplit(newsall[, "article" ], 'googletag') %>% .[[1]] %>% .[1] %>% trimws() %>% strsplit(., '  +') %>% .[[1]] %>% paste(., collapse = ' ')

## 轉換人氣數
#判斷型態
class(applenews$click)

#將factor 轉型回character
newsall$click = as.character(newsall$click)

#抽取一欄
gsub('.{2}\\((\\d+)\\)', '\\1',x = newsall[1,'click'])


#抽取所有列
newsall$click = gsub('.{2}\\((\\d+)\\)', '\\1',x = newsall[,'click']) %>% as.integer()

newsall$dt = strptime(newsall$dt, "%Y年%m月%d日%H:%M")
View(applenews)

newsall[1, "article"]




