library(readxl)
library(dplyr)
library(ggplot2)

icheon <- read_excel("C:/Users/user/Desktop/NIA/icheon/미세먼지관측소정제.xlsx")
View(icheon)

icheon2019 <- icheon %>%
  select(연도, 행정동, PM10, PM2.5) %>%
  filter(연도 == 2019) %>%
  group_by(행정동) %>%
  summarise(PM10_mean = mean(PM10),
            PM2.5_mean = mean(PM2.5))

View(icheon2019)

icheon2020 <- icheon %>%
  select(연도, 행정동, PM10, PM2.5) %>%
  filter(연도 == 2020) %>%
  group_by(행정동) %>%
  summarise(PM10_mean = mean(PM10),
            PM2.5_mean = mean(PM2.5))

icheon2021 <- icheon %>%
  select(연도, 행정동, PM10, PM2.5) %>%
  filter(연도 == 2021) %>%
  group_by(행정동) %>%
  summarise(PM10_mean = mean(PM10),
            PM2.5_mean = mean(PM2.5))


ggplot(icheon2019, aes(x=행정동, y= PM10_mean, PM2.5_mean, fill = 행정동)) + geom_bar(stat='identity') + ggtitle("2019")