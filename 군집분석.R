library(readxl)
library(dplyr)
install.packages("fpc")
install.packages("Rtsne")

### pam : cluster 개수 직접 설정
ssal<-read_excel("C:/Users/CPBUserN/Desktop/한국경제신문/막걸리_최종최종.xlsx")
ssal<- ssal %>% filter(종류==0)
ssal<- ssal %>% select("국", "주원료", "탄산", "살균")

library(cluster)
k<-7    # cluster 개수 설정
pamResult <- pam(ssal, k)
# plot으로 확인
par(mfrow=c(1,2))   # plot 화면 2등분해서 보기 위해 설정
plot(pamResult)
par(mfrow=c(1,1))   # 다시 plot 화면 원래대로 돌려놓기 위해 설정
### pamk : 함수에서 적합한 k를 찾아줌
library(fpc)
pamkResult <- pamk(ssal)
# plot으로 확인
par(mfrow=c(1,2))   # plot 화면 2등분해서 보기 위해 설정
plot(pamkResult)
par(mfrow=c(1,1))   # 다시 plot 화면 원래대로 돌려놓기 위해 설정

#clara 군집
library(cluster)
k <- 5
claraResult <- clara(ssal,7)
# 결과 plot 확인
par(mfrow=c(1,2))
plot(claraResult, color=T, shade=T)
# pairplot 확인
par(mfrow=c(1,1))
#with(ssal, pairs(ssal, col=c(1:k)[claraResult$clustering]))
ssal2<-read_excel("C:/Users/CPBUserN/Desktop/한국경제신문/막걸리_최종최종.xlsx")
ssal2<- ssal2 %>% filter(종류==0)
a = table(claraResult$clustering,ssal2$제품명)
a = as.data.frame(a)
a = a %>% filter(Freq == 1)
View(a)
write.csv(a, "C:/Users/CPBUserN/Desktop/한국경제신문/클라라군집분석7개.csv")

#계층적군집분석
gower_distance <- daisy(ssal, metric = c("gower"))
class(gower_distance)
agg_clust_c <- hclust(gower_distance, method = "ward.D")
plot(agg_clust_c, main = "Agglomerative, Single linkages")
divisive_clust <- diana(as.matrix(gower_distance), 
                        diss = TRUE, keep.diss = TRUE)
plot(divisive_clust, main = "Divisive")
plot(silhouette(cutree(divisive_clust,k=7),dist=dist(ssal),col=1:7))

sil_width <- c(NA)
for(i in 2:7) {
  pam_fit <- pam(gower_distance, diss = TRUE, k = i)
  sil_width[i] <- pam_fit$silinfo$avg.width
}

plot(sil_width,
     xlab = "Number of clusters",
     ylab = "Silhouette Width")
lines(sil_width)
k <- 7
pam_fit <- pam(gower_distance, diss = TRUE, k)
pam_results <- ssal %>%
  mutate(cluster = pam_fit$clustering) %>%
  group_by(cluster) %>%
  do(the_summary = summary(.))
pam_results$the_summary

library(Rtsne)
tsne_obj <- Rtsne(gower_distance, is_distance = TRUE)
tsne_data <- tsne_obj$Y %>%
  data.frame() %>%
  setNames(c("X", "Y")) %>%
  mutate(cluster = factor(pam_fit$clustering))
library(ggplot2)
ggplot(aes(x = X, y = Y), data = tsne_data) +
  geom_point(aes(color = cluster))
View(tsne_obj)

ssal2<-read_excel("C:/Users/CPBUserN/Desktop/한국경제신문/막걸리_최종1.xlsx")
ssal2<- ssal2 %>% filter(종류==0)
a = table(tsne_obj$clustering,ssal2$제품명)
a = as.data.frame(a)
a = a %>% filter(Freq == 1)
View(a)
write.csv(a, "C:/Users/CPBUserN/Desktop/한국경제신문/클라라군집분석.csv")

#의사결정나무
install.packages("party")
library(party)
result<-read.any("C:/Users/CPBUserN/Desktop/한국경제신문/분류.csv", header = T)
set.seed(1234)
resultsplit<-sample(2, nrow(result), replace = TRUE, prob = c(0.7,0.3))
trainD<-result[resultsplit==1,]
testD<-result[resultsplit==2,]
rawD<-단맛~과일+드라이+신맛+고소한맛+제품명
trainModel<-ctree(rawD, data=trainD)
table(predict(trainModel), trainD$단맛)
print(trainModel)
plot(trainModel)

#인코딩
library(devtools)
install_github("plgrmr/readAny", force = TRUE)
library(readAny)
library(readr)
read.any <- function(text, sep = "", ...) {
encoding <- as.character(guess_encoding(text)[1,1])
setting <- as.character(tools::file_ext(text))
if(sep != "" | !(setting  %in% c("csv", "txt")) ) setting <- "custom"
separate <- list(csv = ",", txt = "\n", custom = sep)
result <- read.table(text, sep = separate[[setting]], fileEncoding = encoding, ...)
return(result)
}

#앙상블
result<-read.csv("C:/Users/CPBUserN/Desktop/한국경제신문/라벨링15.csv")
library(ipred)
set.seed(1234)
## nbag = 25  ## 앙상블에 사용되는 의사결정 트리의 갯수가 25개
mybag <- bagging(label_클라라7개 ~ . , data = result, nbagg = 10)
credit_pred <- predict(mybag, result)
table(credit_pred, result$label_클라라7개)
prop.table(table(credit_pred == result$label_클라라7개))
library(caret)
library(e1071)
## numbet = 10
ctrl <- trainControl(method = "cv", number = 10) ## method : 샘플링을 하는 방법을 결정
## number : 리샘플링한 folds의 갯수
train(label_클라라7개 ~ . , data = result, method = "treebag",   trControl = ctrl) ## method : 적용 모델
## numbet = 20
ctrl <- trainControl(method = "cv", number = 20)
train(label_클라라7개 ~ . , data = result, method = "treebag", trControl = ctrl)
## numbet = 30
ctrl <- trainControl(method = "cv", number = 30)
train(label_클라라7개 ~ . , data = result, method = "treebag", trControl = ctrl)
#bagging 모델을 구성하는 의사결정나무 그래프(첫번째)
install.packages("rpart.plot")
library(rpart.plot)
rpart.plot(mybag$OOB)

#의사결정나무만들기
library(rattle)				# Fancy tree plot
library(rpart.plot)			# Enhanced tree plots
library(RColorBrewer)			# Color selection for fancy tree 


#배깅판별분석
library(adabag)
set.seed(1234)
train <- sample(1:1700, 1500) #무작위로 100개 추출 (학습데이터)
result.bagging <- bagging(label_클라라7개 ~단맛 + 과일+ 신맛+ 고소한맛+ 드라이,data=result[train, ],mfinal=5,  #5개 의사결정나무 이용
                        control=rpart.control(maxdepth=5, minsplit=5)) #최대깊이 5, 최소 노드 5
result.bagging$mtrees #각각 의사결정나무 결과보기

rf_p <- predict(result.bagging, newdata = result[-train,], type = "class")

library(rpart.plot)
rpart.plot(result.bagging$mtrees[[1]])

predict(result.bagging, result[-train,])
tt <- table(result$label_클라라7개[-train], predict(result.bagging, result[-train,]))
View(tt)


confusionMatrix(rf_p, result$label_클라라7개)

resultsplit<-sample(2, nrow(result), replace = TRUE, prob = c(0.7,0.3))
trainD<-result[resultsplit==1,]
testD<-result[resultsplit==2,]

#퍼지군집
install.packages("fclust")
install.packages("cclust")
library(fclust)
library(cclust)
library(readxl)
result<-read_excel("C:/Users/CPBUserN/Desktop/한국경제신문/막걸리_최종최종.xlsx")
result <- result %>% select("주원료", "국", "탄산", "살균")
x1_x2_FKM <- FKM(X = result, # Matrix or data.frame
                 k = 4, # Number of clusters (default: 2) 
                 m = 2) # Parameter of fuzziness (default: 2)
x1_x2_FKM
x1_x2_FKM$U #소속정도의 가중치
x1_x2_FKM$H #퍼지군집의 중심 위치
pred <- x1_x2_FKM$cluster
plot(x1_x2_FKM, col=pred)
par(mfrow=c(1,2))
points(x1_x2_FKM$H)

#퍼지군집2
set.seed(1234)
fuz_f_2<-fanny(result, 16)
plot(fuz_f_2)

#차원축소
pca <- function(dataset){
  pc = prcomp(dataset, scale = TRUE)
  k=0
  R=0
  
  while(R < 0.8) {
    k = k+1
    R = sum(pc[[1]][1:k]^2)/sum(pc[[1]]^2)
    cat("When number of Principal Component(k) is ", k,
        ", Cumulative Proportion(R) is ", R, "\n", "\n", sep="")
  }
  SelectedDataSet = pc[[5]][,1:k]
  return(SelectedDataSet)
}
pca_re<-pca(result[,c(1:2)])

secu_prcomp <- prcomp(pca_re)
summary(secu_prcomp)

a <- secu_prcomp$x
#Clustering - Fuzzy C Means Clustering
install.packages("pplust")
install.packages("factoextra")
install.packages("ppclust")
library(pplust)
library(ppclust)
library(factoextra)
library(psych)
#pairs.panels(a, method = "pearson")
res.fcm <- fcm(a, centers=15) #fuzzy군집
res.fcm3 <- ppclust2(res.fcm, "fanny")
cluster::clusplot(scale(result), res.fcm3$cluster,  
                  main = "막걸리군집",
                  color=TRUE, labels = 2, lines = 2, cex=1) #fuzzy군집그래프
View(a)
write.csv(a, "C:/Users/CPBUserN/Desktop/한국경제신문/a.csv")
plot(res.fcm4)
#plotcluster(res.fcm, cp=1, trans=TRUE)
#res.fcm2 <- ppclust2(res.fcm, "kmeans")

# Fuzzy Silhouette Index:
res.fcm4 <- ppclust2(res.fcm, "fclust")
idxsf <- SIL.F(res.fcm4$Xca, res.fcm4$U, alpha=1)
paste("Fuzzy Silhouette Index: ",idxsf)

#plotcluster(res.fcm, cp=3, trans=TRUE)
#fviz_cluster(res.fcm2, data = a, 
             #ellipse.type = "convex",
             #palette = "jco",
             #repel = TRUE)