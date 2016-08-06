# (https://rpubs.com/a5347354/200105)
library(rvest)
download.file('https://raw.githubusercontent.com/ywchiu/rtibame/master/Data/kcfor2016_utf8.csv', 'kcfor2016_utf8.csv')
news = read.csv(file = 'kcfor2016_utf8.csv')
#使用老師寫好的function
source('https://raw.githubusercontent.com/ywchiu/rtibame/master/Lib/CNCorpus.R')
library(jiebaR)
mixseg = worker()
#lappy一篇一篇文章切割字詞並串連，e = applenews$content
news_sec = lapply(as.String(news$message), function(e) segment(code = e, jiebar=mixseg))

s_corpus = CNCorpus(news_sec)
#字詞長度至少2以上，control wordLengths可以控制搜集的字詞長度
control_list=list(wordLengths=c(2,Inf),tokenize=space_tokenizer)
#移除不必要的字元
s_corpus = tm_map(s_corpus, removeNumbers) 
s_corpus = tm_map(s_corpus, removePunctuation)
dtm <- DocumentTermMatrix(s_corpus,control=control_list)

tb = table(news_sec)

#尋找詞頻大於10的詞
freq_term = findFreqTerms(dtm, lowfreq = 10)
freq_term
#排序後取出freq_term的長度
candicate = tb %>% sort(.,decreasing = TRUE) %>% head(.,length(freq_term))
candicate

#產生文字雲
library(wordcloud2)
#轉換成table後產生文字雲
wordcloud2(as.table(candicate),shape = 'star',size = 3)