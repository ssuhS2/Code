# -*- coding: utf-8 -*-
"""
Created on Wed Oct  7 10:28:27 2020

@author: CPBUserN
"""

import sys
import io
sys.stdout = io.TextIOWrapper(sys.stdout.detach(), encoding = 'utf-8')
sys.stderr = io.TextIOWrapper(sys.stderr.detach(), encoding = 'utf-8')

import pandas as pd
import numpy as np
import matplotlib.pyplot as plt 

matching1 = pd.read_excel('회원matching.xlsx', sheet_name = 0)
matching2 = pd.read_excel('회원matching.xlsx', sheet_name = 1)
matching3 = pd.read_excel('회원matching.xlsx', sheet_name = 2)
matching4 = pd.read_excel('회원matching.xlsx', sheet_name = 3)
matching5 = pd.read_excel('회원matching.xlsx', sheet_name = 4)

matching = pd.concat([matching1, matching2, matching3, matching4, matching5], ignore_index = True)

#교환하지 않은 기프티쇼
isna_exchange = matching.fillna(0)
filter_isna_exchange = isna_exchange[isna_exchange['교환일시'] == 0]
del filter_isna_exchange['Unnamed: 0']

filter_isna_exchange.to_excel('교환 필터링.xlsx')

isna_exchange = filter_isna_exchange.groupby('브랜드명').count()
isna_exchange = isna_exchange[['교환일시']]
isna_exchange.rename(columns = {'교환일시' : '교환X'}, inplace = True)

isna_exchange.to_excel('브랜드별 not exchanged.xlsx')

brand = pd.read_excel('브랜드별 매출.xlsx')
brand.set_index('브랜드명', inplace=True)
brand = brand[['발송일시']]
brand.rename(columns = {'발송일시' : '발송'}, inplace = True)

exchange = pd.concat([brand, isna_exchange], axis = 1, join = 'outer')
exchange.to_excel('브랜드별 교환.xlsx')

## B2C 데이터_실물 교환: 브랜드별
brand = pd.read_excel('브랜드별 매출.xlsx')
brand.set_index('브랜드명', inplace=True)
brand = brand[['발송일시', '교환일시']]
brand.rename(columns = {'발송일시' : '발송', '교환일시' : '교환'}, inplace = True)
brand = brand.assign(exchange = lambda brand: (brand['교환']/ brand['발송'])*100)

brand.to_excel('B2C데이터 교환_브랜드별.xlsx')

## B2C 데이터_실물 교환: 상품별
product = pd.read_excel('상품별 매출.xlsx')
product.rename(columns = {'발송일시' : '발송', '교환일시' : '교환'}, inplace = True)
product.set_index('상품명', inplace=True)
product = product[['발송', '교환']]
product = product.assign(exchange = lambda product: (product['교환']/ product['발송'])*100)

product.to_excel('B2C데이터 교환_상품별.xlsx')