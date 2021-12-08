coupon = read.csv("(합계만)온라인쇼핑몰_판매매체별_상품군별거래액.csv", header = T)

library(ggplot2)
library(dplyr)
library(ggthemes)
install.packages('lubridate')
library('lubridate')

coupon$비율 <- coupon$e쿠폰서비스/coupon$합계*100

ecoupon <- ggplot(coupon, aes(x=시점, y=비율, group=1))+ 
  geom_line(size=1, colour = 'darkblue')+ 
  labs(x='Time Series (2017-2020)', 
       y='Market Share (%)')+
  theme_classic()+
  theme(axis.title = element_text(family = 'serif', 
                       face = 'bold',
                       hjust = 0.5, 
                       size = 24, colour = 'black'))+
  scale_x_discrete(breaks=NULL)
  
ecoupon

