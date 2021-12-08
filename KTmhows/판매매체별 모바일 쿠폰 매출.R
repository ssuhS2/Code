library(readxl)
channel = read_excel("판매매체별 모바일 쿠폰 매출액.xlsx")

library(ggplot2)
library(dplyr)
library(ggthemes)

channel$Internet = channel$인터넷쇼핑/channel$계*100
channel$Mobile = channel$모바일쇼핑/channel$계*100

recent <- channel[44,5:6]
recent <- t(recent)

pie(recent, 
    init.angle=90, 
    radius = 0.9,
    clockwise= T,
    labels=channel$V1)

