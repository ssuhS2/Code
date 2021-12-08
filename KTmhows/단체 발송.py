# -*- coding: utf-8 -*-
"""
Created on Tue Oct 13 17:05:36 2020

@author: CPBUserN
"""

import pandas as pd

group = pd.read_excel('★단체발송_remove.xlsx')

customer=group.groupby('고객사명').count()
customer.to_excel('group_고객사별 거래건수.xlsx')

product=group.groupby('상품명').count()
product.to_excel('group_상품별 판매건수.xlsx')

brand=group.groupby('브랜드명').count()
brand.to_excel('group_브랜드별 판매건수.xlsx')

message=group.groupby('메세지내용').count()
message.to_excel('group_메세지내용 빈도수.xlsx')

sender=group.groupby('발신자번호').count()
sender.to_excel('group_발신자 빈도수.xlsx')

group_ex=group.groupby('상품명').count()
group_ex.to_excel('group_상품별 교환비율.xlsx')

group_ex=group.groupby('브랜드명').count()
group_ex.to_excel('group_브랜드별 교환비율.xlsx')

#final
product_brand = group.groupby(['상품명', '브랜드명']).count()
product_brand = product_brand.loc[:,['Unnamed: 0', '발송일시', '교환일시']]
product_brand.rename(columns = {'Unnamed: 0' : '건수', '발송일시' : '판매', '교환일시' : '교환'}, inplace = True)
product_brand['교환 비율'] = product_brand['교환']/product_brand['판매']*100

product_brand.to_excel('group_상품-브랜드별 판매건수.xlsx')

price = pd.read_csv('20만건_상품별단가.csv', encoding = 'cp949', index_col = 0)
transaction = pd.read_excel('group_상품-브랜드별 판매건수.xlsx')

transaction = transaction.merge(price, on='상품명', how='outer')

transaction.to_excel('★group_기프티쇼 판매교환.xlsx')
