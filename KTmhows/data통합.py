# -*- coding: utf-8 -*-
"""
Spyder Editor

This is a temporary script file.
"""

import pandas as pd
from pandas import DataFrame
from pandas import Series
import numpy as np
import matplotlib as plt

data1 = pd.read_excel('PMS1234_2019_B2C_데이터.xlsx', sheet_name ='워크시트 익스포트')
data2 = pd.read_excel('PMS1234_2019_B2C_데이터.xlsx', sheet_name = 1)
data3 = pd.read_excel('PMS1234_2019_B2C_데이터.xlsx', sheet_name = 2)
data4 = pd.read_excel('PMS1234_2019_B2C_데이터.xlsx', sheet_name = 3)
data5 = pd.read_excel('PMS1234_2019_B2C_데이터.xlsx', sheet_name = 4)

total_data = pd.concat([data1, data2, data3, data4, data5], ignore_index = True)

customer=total_data.groupby('고객사명').count()
customer.to_excel('고객사별 매출.xlsx')

product=total_data.groupby('상품명').count()
product.to_excel('상품별 매출.xlsx')

brand=total_data.groupby('브랜드명').count()
brand.to_excel('브랜드별 매출.xlsx')

message=total_data.groupby('메세지내용').count()
message.to_excel('메세지내용 빈도수.xlsx')

sender=total_data.groupby('발신자번호').count()
sender.to_excel('발신자 빈도수.xlsx')

sex_age = pd.read_excel('한국경제신문관련회원데이터추출_20200914.xlsx', index_col = 1, skiprows=1)
sex_age = sex_age.iloc[:, 1:3]

sex=sex_age.groupby('성별').count()
sex.to_excel('성별 이용자수.xlsx')

age=sex_age.groupby('생년').count()
age.to_excel('생년별 이용자수.xlsx')
