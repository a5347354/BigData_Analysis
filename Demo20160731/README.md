課程講義https://github.com/ywchiu/rtibame

程式Demo  http://rpubs.com/a5347354/199507

建立中文詞頻矩陣時，會產生錯誤詞頻
解法：使用Function [CNCorpus](https://raw.githubusercontent.com/a5347354/BigData_Analysis/master/Demo20160731/CNCorpus.R)

學習分為演繹和歸納

機器學習的目的是**「歸納Induction」**

以前電腦資料不足無法做學習

## 監督式學習 (Supervised Learning)

> 根據有已知答案、類別、標籤的資料進行訓練
   - 迴歸分析 (Regression)：資料有連續型的資料
   - 分類問題 (Classification)：資料為類別資料

## 非監督式學習 (Unsupervised Learning)
> 沒有已知的答案、類別、標籤
   - 降低維度 (Dimension Reduction)：濃縮用到的特徵(指標)，編成新的指標，降低問題的複雜度（可做壓縮 Ex:圖片壓縮）
   - 分群問題 (Clustering)：近朱者赤，近墨者黑 Ex:將客戶分層

## 機器學習過程
   !["機器學習過程"](ml_map.png "機器學習過程")

### Q&A
> findAssocs(dtm, '大巨蛋’, 0.7)
> * 有什麼樣的缺點
> * 如何刪除離群值
