library(rvest)
appleurl = "http://www.appledaily.com.tw/realtimenews/section/new/"
rtddt = read_html(appleurl) %>% html_nodes(".rtddt a")
titles = rtddt %>% html_nodes("h1") %>% html_text()
newtimes = rtddt %>% html_nodes("time") %>% html_text()
catagorys = rtddt %>% html_nodes("h2") %>% html_text()
links = rtddt %>% html_attr("href")
links = paste0("http://www.appledaily.com.tw", links)

dfall = data.frame(title = character(), 
                   article= character(),
                   click = character(), 
                   dt =character(),
                   category= character())
for(ele in rtddt){
  catagorys = ele %>% html_nodes("h2") %>% html_text()
  links = ele %>% html_attr("href")
  links = paste0("http://www.appledaily.com.tw", links)
  df = getContant(links)
  appleDF = rbind()
}

print(tra)


#GetContant
getContant = function(contantUrl, catagory){
  trans = read_html(contantUrl)
  time = trans %>% html_nodes(".gggs time") %>% html_text()
  title = trans %>% html_nodes(".strange") %>% html_text()
  contants = trans %>% html_nodes(".trans #summary") %>% html_text()
  df = data.frame(time = time, title = title, contants = contants, catagory = catagory)
}