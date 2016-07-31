課程講義https://github.com/ywchiu/rtibame

程式Demo  http://rpubs.com/a5347354/199349

google搜尋趨勢 http://www.google.com.tw/trends

文字探勘中最重要的就是要有好的字典
領域字典Ex:反核、泛核

中文斷詞技術

- 利用字典比對法
- 分正反面
- 長度優先比對，分為最長優先與最短優先（大巨蛋以及巨蛋）
    - 長詞優先法為最普遍被廣泛使用的斷詞方法
    - 正確率可達90%
- 按照詞性去斷詞
- 語義分析，將主詞動詞寫下來->需耗費大量的人力

基於統計的斷詞方法n-gram（最簡單的斷詞方法）

- n=3，3個字為一個詞

jiebaR 結巴R（原在python）

- 有許多的版本
- 字典檔在jeba.dict.utf8

演算法流程

- 使用正規表達法
- 利用資料結構Trie => 王-永慶  王 -子
- 動態規劃
- 利用HMM隱馬爾可夫模型，為一個機率模型

隱馬爾可夫模型
切詞範例

- 柯文哲相關資訊與新聞
- B M E B E  B  E S B E
- B=Begin，M=Middle，E=End，S=Single
- 可調整隱馬爾可夫模型參數在hmm_model.utf8

NLPchina

- 精準度高
- 速度快
- 效果好

若要判斷這篇是正面還是負面

- 情緒詞
- https://github.com/bingo4508/facebook-sentiment-analysis
- 但華人有個缺點，會說反話 => 好棒棒

字典擴充地方
爬蟲：
     自由時報的關鍵字
字典：
     維基百科
     萌典

Q&A
如何抓google搜尋
