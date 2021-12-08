# -*- coding: utf-8 -*-
"""
Created on Wed Sep 23 09:33:45 2020

@author: CPBUserN
"""
import pandas as pd
b2c_data1 = pd.read_excel('PMS1234_2019_B2C_데이터.xlsx', sheet_name ='워크시트 익스포트')
b2c_data2 = pd.read_excel('PMS1234_2019_B2C_데이터.xlsx', sheet_name = 1)
b2c_data3 = pd.read_excel('PMS1234_2019_B2C_데이터.xlsx', sheet_name = 2)
b2c_data4 = pd.read_excel('PMS1234_2019_B2C_데이터.xlsx', sheet_name = 3)
b2c_data5 = pd.read_excel('PMS1234_2019_B2C_데이터.xlsx', sheet_name = 4)

customer_data = pd.read_excel('한국경제신문관련회원데이터추출_20200921_회원.xlsx')

b2c_data1 = pd.merge(left = b2c_data1, right = customer_data, how = 'inner', left_on = '발신자번호', right_on = '전화번호')
b2c_data2 = pd.merge(left = b2c_data2, right = customer_data, how = 'inner', left_on = '발신자번호', right_on = '전화번호')
b2c_data3 = pd.merge(left = b2c_data3, right = customer_data, how = 'inner', left_on = '발신자번호', right_on = '전화번호')
b2c_data4 = pd.merge(left = b2c_data4, right = customer_data, how = 'inner', left_on = '발신자번호', right_on = '전화번호')
b2c_data5 = pd.merge(left = b2c_data5, right = customer_data, how = 'inner', left_on = '발신자번호', right_on = '전화번호')

b2c_data1.to_excel('회원matching1.xlsx')
b2c_data2.to_excel('회원matching2.xlsx')
b2c_data3.to_excel('회원matching3.xlsx')
b2c_data4.to_excel('회원matching4.xlsx')
b2c_data5.to_excel('회원matching5.xlsx')

b2c_data = pd.concat([b2c_data1, b2c_data2, b2c_data3, b2c_data4, b2c_data5], ignore_index = True)

sex=b2c_data.groupby('성별').count()
sex.to_excel('성별 이용자수.xlsx')

age=b2c_data.groupby('생년').count()
age.to_excel('생년별 이용자수.xlsx')

b2c_data_4050 = b2c_data.loc[:, ['생년', '브랜드명', '성별']]
b2c_data_4050 = b2c_data.loc[[1961, 1962, 1963, 1964, 1965, 1967, 1968, 1969, 1970, 1971, 1972, 1972, 1973, 1974, 1975, 1976, 1977, 1978, 1979, 1980],:]
print(b2c_data_4050)

b2c_data_4050.to_excel('4050.xlsx')
