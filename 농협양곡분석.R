library(readxl)
rice<-read_excel("C:/Users/CPBUserN/Documents/카카오톡 받은 파일/쌀출하가소매가.xlsx")
library(dplyr)
r2013 <- rice %>%
  filter(연 == "2013")

#상관관계 분석
library(readxl)
price<-read_excel("C:/Users/CPBUserN/Desktop/농협양곡/지역별쌀가격_정제.xlsx")
eco<-read_excel("C:/Users/CPBUserN/Desktop/a.xlsx")
han<-read_excel("C:/Users/CPBUserN/Desktop/농협양곡/환율1.xlsx")
export<-read_excel("C:/Users/CPBUserN/Desktop/농협양곡/쌀수출량.xlsx")
library(dplyr)
eco_cor<-left_join(price, export, by = c("년","월"))
View(eco_cor)
eco_cor<-eco_cor[,c("쌀소매가","수출중량")]
cor.test(eco_cor$쌀소매가, eco_cor$수출중량)
cor(eco_cor)
han2<-left_join(price, han, by = c("지역","년","월"))
cor.test(han2$쌀소매가, han2$환율)

price_m<-read_excel("C:/Users/CPBUserN/Desktop/농협양곡/전국_월별_쌀가격.xlsx")
cortest_m<-left_join(CPI, price_m, by = c("년", "월")) #월별 상관관계분석
cor.test(cortest_m$CPI, cortest_m$소매가)
View(price_m)
View(cortest_m)

CPI13<-read_excel("C:/Users/CPBUserN/Desktop/소비자물가지수13.xlsx")
cortest_m<-left_join(CPI13, price_m, by = c("년", "월"))
cor.test(cortest_m$CPI, cortest_m$소매가)

#상관관계분석 19개년
library(readxl)
library(dplyr)
price_y <- read_excel("C:/Users/CPBUserN/Desktop/농협19/소매가1018_년.xlsx")
price_m <- read_excel("C:/Users/CPBUserN/Desktop/농협19/소매가1018_월.xlsx")
price_q <- read_excel("C:/Users/CPBUserN/Desktop/농협19/소매가1018_분기.xlsx")
GDP_d<-read_excel("C:/Users/CPBUserN/Desktop/농협19/GDP디플레이터.xlsx")
CPI<-read_excel("C:/Users/CPBUserN/Desktop/농협19/소비자물가지수.xlsx")
GDP<-read_excel("C:/Users/CPBUserN/Desktop/농협19/GDP.xlsx")
han<-read_excel("C:/Users/CPBUserN/Desktop/농협19/환율.xlsx")
import<-read.csv("C:/Users/CPBUserN/Desktop/농협19/수입중량.csv")
export<-read_excel("C:/Users/CPBUserN/Desktop/농협19/수출중량.xlsx")
eco_q<-read_excel("C:/Users/CPBUserN/Desktop/농협19/분기별경제.xlsx")
#1015분석
eco_m<-read_excel("C:/Users/CPBUserN/Desktop/농협19/월별경제1015.xlsx")
cor(eco_m)
cor.test(eco_m$쌀소매가, eco_m$CPI)
cor.test(eco_m$쌀소매가, eco_m$환율)
cor.test(eco_m$쌀소매가, eco_m$수출중량)

cortest_q<-left_join(GDP, price_q, by = c("년","분기"))
cor.test(cortest_q$명목GDP, cortest_q$쌀소매가)

price_m1<-read_excel("C:/Users/CPBUserN/Desktop/농협19/소매가19년_월별.xlsx")
a<-left_join(CPI, price_m1, by = c("년","월"))
cor.test(a$CPI, a$쌀소매가)


a<-left_join(han, price_m1, by = c("년","월"))
cor.test(a$환율, a$쌀소매가)


import <- import %>%
  filter(지역 == "서울")
a<-left_join(import, price_m1, by = c("년","월"))
cor.test(a$수입중량, a$쌀소매가)


a<-left_join(export, price_m1, by = c("년","월"))
cor.test(a$수입중량, a$쌀소매가)
View(export)
GDP1<-GDP %>%
  filter(년 != 2016)
GDP1<-GDP1 %>%
  filter(년 != 2017)
GDP1<-GDP1 %>%
  filter(년 != 2018)

price_q1<-price_q %>%
  filter(년 != 2016)
price_q1<-price_q1 %>%
  filter(년 != 2017)
price_q1<-price_q1 %>%
  filter(년 != 2018)
View(price_q1)
cortest_q<-left_join(GDP, price_q1, by = c("년","분기"))
cor.test(cortest_q$명목GDP, cortest_q$쌀소매가)

price_y1<-price_y %>%
  filter(년 != 2016)
price_y1<-price_y1 %>%
  filter(년 != 2017)
price_y1<-price_y1 %>%
  filter(년 != 2018)

import1<-import %>%
  filter(년 != 2016)
import1<-import1 %>%
  filter(년 != 2017)
import1<-import1 %>%
  filter(년 != 2018)
View(import1)

price_m1<-price_m %>%
  filter(년 != 2016)
price_m1<-price_m1 %>%
  filter(년 != 2017)
price_m1<-price_m1 %>%
  filter(년 != 2018)

CPI1<-CPI %>%
  filter(년 != 2016)
CPI1<-CPI1 %>%
  filter(년 != 2017)
CPI1<-CPI1 %>%
  filter(년 != 2018)

export1<-export %>%
  filter(년 != 2016)
export1<-export1 %>%
  filter(년 != 2017)
export1<-export1 %>%
  filter(년 != 2018)

han1<-han %>%
  filter(년 != 2016)
han1<-han1 %>%
  filter(년 != 2017)
han1<-han1 %>%
  filter(년 != 2018)
library(dplyr)
eco<-left_join(han1, price_m1, by = c("년", "월"))
cor.test(eco$환율, eco$쌀소매가)

eco<-left_join(CPI1, price_m1, by = c("년", "월"))
cor.test(eco$CPI, eco$쌀소매가)

eco<-left_join(export1, price_m1, by = c("년", "월"))
cor.test(eco$수출중량, eco$쌀소매가)

eco<-left_join(import1, price_m1, by = c("년", "월"))
cor.test(eco$수입중량, eco$쌀소매가)

a<-left_join(GDP_d, price_q, by = c("년", "분기"))
cor.test(a$디플레이터, a$쌀소매가)

GDP_d1<-GDP_d %>%
  filter(년 != 2016)
GDP_d1<-GDP_d1 %>%
  filter(년 != 2017)
GDP_d1<-GDP_d1 %>%
  filter(년 != 2018)
eco<-left_join(GDP_d1, price_q1, by = c("년", "분기"))
cor.test(eco$디플레이터, eco$쌀소매가)

cor(eco_m)
cor(eco_q)

eco_m1<-eco_m %>%
  filter(년 != 2016)
eco_m1<-eco_m1 %>%
  filter(년 != 2017)
eco_m1<-eco_m1 %>%
  filter(년 != 2018)
eco_m11<-eco_m1[,c("쌀소매가","수출중량","CPI", "환율", "수입중량")]
cor(eco_m1)

eco_q1<-eco_q %>%
  filter(년 != 2016)
eco_q1<-eco_q1 %>%
  filter(년 != 2017)
eco_q1<-eco_q1 %>%
  filter(년 != 2018)
cor(eco_m1)
View(eco_m1)

cor.test(eco_q1$쌀소매가, eco_q1$명목GDP)
cor.test(eco_q1$쌀소매가, eco_q1$명목GDP)

eco_m2<-eco_m %>%
  filter(년 != 2010)
eco_m2<-eco_m2 %>%
  filter(년 != 2011)
eco_m2<-eco_m2 %>%
  filter(년 != 2012)
eco_m2<-eco_m2 %>%
  filter(년 != 2013)
eco_m2<-eco_m2 %>%
  filter(년 != 2014)
eco_m2<-eco_m2 %>%
  filter(년 != 2015)

cor(eco_m2)
View(eco_m2)

eco_q2<-eco_q %>%
  filter(년 != 2010)
eco_q2<-eco_q2 %>%
  filter(년 != 2011)
eco_q2<-eco_q2 %>%
  filter(년 != 2012)
eco_q2<-eco_q2 %>%
  filter(년 != 2013)
eco_q2<-eco_q2 %>%
  filter(년 != 2014)
eco_q2<-eco_q2 %>%
  filter(년 != 2015)
cor(eco_q2)

cor.test(eco_q2$쌀소매가, eco_q2$명목GDP)
cor.test(eco_q2$쌀소매가, eco_q2$디플레이터)
cor.test(eco_q1$쌀소매가, eco_q1$명목GDP)
cor.test(eco_q1$쌀소매가, eco_q1$디플레이터)

cor.test(eco_m2$쌀소매가, eco_m2$CPI) #유의미
cor.test(eco_m2$쌀소매가, eco_m2$환율)
cor.test(eco_m2$쌀소매가, eco_m2$수입중량)
cor.test(eco_m2$쌀소매가, eco_m2$수출중량)
cor.test(eco_m1$쌀소매가, eco_m1$CPI)
cor.test(eco_m1$쌀소매가, eco_m1$환율)
cor.test(eco_m1$쌀소매가, eco_m1$수입중량)
cor.test(eco_m1$쌀소매가, eco_m1$수출중량)
plot(eco_m)

library(corrplot)
library(PerformanceAnalytics)
install.packages("PerformanceAnalytics")
eco_mm<-eco_cor[,c("쌀소매가","수출중량","CPI", "환율", "수입중량")]

chart.Correlation(eco_m11, histogram=TRUE, pch=19) #10-15
chart.Correlation(eco_mm, histogram=TRUE, pch=19) #10-18

plot(export$년, export$수출중량, type='l')
plot(import$월, import$수입중량, type='l')

library(ggplot2)
ggplot(data=export,aes(x=년,y=수출중량))+geom_line()+geom_point()
ggplot(data=import,aes(x=년,y=수입중량))+geom_line()

eco_m2017<-read_excel("C:/Users/CPBUserN/Desktop/농협19/월별경제_17.xlsx")
eco_m2017<-eco_m2017[,c("쌀소매가","수출중량","CPI", "환율", "수입중량")]
eco_m2017_1<-read_excel("C:/Users/CPBUserN/Desktop/농협19/월별경제17_원래.xlsx")
eco_m2017_1<-eco_m2017_1[,c("쌀소매가","수출중량","CPI", "환율", "수입중량")]
cor(eco_m2017)
cor(eco_m2017_1)

#10-18추정치
eco_m<-read_excel("C:/Users/CPBUserN/Desktop/농협19/월별추정치통계_18.xlsx")
cor(eco_m)
cor.test(eco_m$쌀소매가, eco_m$CPI) #1.939e-06
cor.test(eco_m$쌀소매가, eco_m$환율) #0.0003775
cor.test(eco_m$쌀소매가, eco_m$수입중량) #0.2709
cor.test(eco_m$쌀소매가, eco_m$수출중량) #0.286
cor.test(eco_m$쌀소매가, eco_m$미국선물) #0.000366
cor.test(eco_m$쌀소매가, eco_m$태국선물) #0.9298

#회귀1018월별 - 경제
eco_1018<-read_excel("C:/Users/CPBUserN/Desktop/농협19/월회귀_1018.xlsx")
View(eco_1018)
eco1018<-lm(formula = 쌀소매가~미국선물+특등+일등+이등+삼등+직접비+간접비+출하+도매, data = eco_1018)
summary(eco1018)
library(car)
vif(eco1018)

#회귀1018월별 - 인구
people_1018<-read.csv("C:/Users/CPBUserN/Desktop/농협19/다영_인구데이터1018.csv")
people1018<-lm(formula = 쌀소매가 ~ 청소년인구수_mean+노인인구수_mean+출생아수+총인구수, data = people_1018)
summary(people1018)

#회귀1015월별 - 인구
people_1015<-read.csv("C:/Users/CPBUserN/Desktop/농협19/다영_인구데이터1018.csv")
people1015<-lm(formula = 쌀소매가 ~ 청소년인구수_mean+노인인구수_mean+출생아수+총인구수, data = people_1015)
summary(people1015)

#10-15
library(readxl)
eco_m15<-read_excel("C:/Users/CPBUserN/Desktop/농협19/월별경제1015.xlsx")
cor(eco_m15)
cor.test(eco_m15$쌀소매가, eco_m15$CPI) #1.355e-15
cor.test(eco_m15$쌀소매가, eco_m15$환율) #9.624e-06
cor.test(eco_m15$쌀소매가, eco_m15$수입중량) #0.03837
cor.test(eco_m15$쌀소매가, eco_m15$수출중량) #5.368e-05
cor.test(eco_m15$쌀소매가, eco_m15$미국선물) #0.1935
cor.test(eco_m15$쌀소매가, eco_m15$태국선물) #0.4612
cor.test(eco_m15$쌀소매가, eco_m15$감자생산자물가지수) #0.0001378
cor.test(eco_m15$쌀소매가, eco_m15$생우유생산자물가지수) #1.89e-12
cor.test(eco_m15$쌀소매가, eco_m15$달걀생산자물가지수) #0.005081
cor.test(eco_m15$쌀소매가, eco_m15$경제심리지수) #3.387e-14
chart.Correlation(eco_m15, histogram=TRUE, pch=19) #10-18
#회귀1015월별 - 경제
library(readxl)
eco_1015<-read_excel("C:/Users/CPBUserN/Desktop/농협19/월회귀_1015.xlsx")
View(eco_1015)
eco1015<-lm(formula = 쌀소매가~CPI+환율+수출중량+소고기생산자물가지수+감자생산자물가지수+생우유생산자물가지수+달걀생산자물가지수, data = eco_1015)
summary(eco1015)
install.packages("psych")
install.packages("car")
library(psych)
library(car)
vif(eco1015)
eco1015<-lm(formula = 쌀소매가~+환율+수출중량+소고기생산자물가지수+감자생산자물가지수+생우유생산자물가지수+달걀생산자물가지수, data = eco_1015)
eco1015_b <- step(eco1015, direction = "backward")
install.packages("QuantPsyc")
install.packages("lm.beta")
library(QuantPsyc)
library(lm.beta)
lm.beta(eco1015)

#워드클라우드
install.packages("rlang")
library(readxl)
library(KoNLP)
library(wordcloud)
library(devtools)
library(RColorBrewer)
library(stringr)
wc<-read_excel("C:/Users/CPBUserN/Desktop/농협양곡/1019쌀값or쌀가격.xlsx")
trend<-read_excel("C:/Users/CPBUserN/Desktop/농협양곡/1019트렌드.xlsx")
write(unlist(trend), "wc1.txt")
wc2<-readLines("wc1.txt")
wc3<-str_replace_all(wc2, ",", " ")
wc3<-gsub("\\d+", "", wc3)
wc3<-gsub("식습관", "", wc3)
View(wc3)
nouns<-extractNoun(wc3)
wordcount<-table(unlist(nouns))
#wordcount<-table(unlist(wc3))
df_word<-as.data.frame(wordcount, stringsAsFactors = F)
library(dplyr)
df_word<-rename(df_word, word=Var1, freq=Freq)
df_word <- filter(df_word, nchar(word)>=2)
View(df_word)
pal<-brewer.pal(9, "Set1")
set.seed(1234)
wordcloud(words = df_word$word, freq = df_word$freq,
          min.freq = 1, max.words = 400, random.order = F,
          rot.per = .1, scale = c(4, 0.1), colors = pal)
library(RColorBrewer)
library(wordcloud2)
wordcloud2(df_word)
pal <- brewer.pal(7,"Set2")
color_range_number <- length(unique(df_word$freq))
color <- colorRampPalette(brewer.pal(9,"Blues")[3:7])(color_range_number)[factor(df_word$freq)]
set.seed(1234)
wordcloud2(df_word, size=1, col=color)

total<-read_excel("C:/Users/CPBUserN/Documents/카카오톡 받은 파일/통합데이터_1018.xlsx")
cor(total)
total15<-read_excel("C:/Users/CPBUserN/Documents/카카오톡 받은 파일/통합데이터_1018_뒤.xlsx")
cor(total15)

total15<-read_excel("C:/Users/CPBUserN/Documents/카카오톡 받은 파일/통합데이터_1018.xlsx")
cor(total15)
total<-read_excel("C:/Users/CPBUserN/Desktop/뒤1015.xlsx")
cor(total)
