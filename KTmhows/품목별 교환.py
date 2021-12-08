# -*- coding: utf-8 -*-

import pandas as pd

#Backdata 추출
item = pd.read_excel('B2C데이터 교환_상품별.xlsx', sheet_name = 1)
item.rename(columns = {'Unnamed: 5' : 'Rank'}, inplace = True)
item = item.iloc[:, 0:7]

#카페
item_cafe = item[(item['카테고리']=='카페') & (item['Rank']=='상위10%')]
