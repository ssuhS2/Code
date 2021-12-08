# -*- coding: utf-8 -*-
"""
Created on Fri Oct 16 16:45:55 2020

@author: CPBUserN
"""

import pandas as pd
import numpy as np

mem1 = pd.read_excel("회원matching.xlsx", sheet_name= 0)
mem2 = pd.read_excel("회원matching.xlsx", sheet_name= 1)
mem3 = pd.read_excel("회원matching.xlsx", sheet_name= 2)
mem4 = pd.read_excel("회원matching.xlsx", sheet_name= 3)
mem5 = pd.read_excel("회원matching.xlsx", sheet_name= 4)

mem = pd.concat([mem1, mem2, mem3, mem4, mem5])

ageg = mem[['생년', '브랜드명', '상품명']]
ageg = ageg.groupby(['생년','브랜드명', '상품명']).count()

price = pd.read_csv("20만건_상품별단가.csv", encoding = 'cp949')

