# -*- coding: utf-8 -*-
"""
Created on Thu Oct 15 20:51:03 2020

@author: CPBUserN
"""

import sys
import io
sys.stdout = io.TextIOWrapper(sys.stdout.detach(), encoding = 'utf-8')
sys.stderr = io.TextIOWrapper(sys.stderr.detach(), encoding = 'utf-8')

from matplotlib import font_manager, rc
font_name = font_manager.FontProperties(fname="c:/Windows/Fonts/malgun.ttf").get_name()
rc('font', family=font_name, size=8)

import pandas as pd
import matplotlib.pyplot as plt
plt.rcParams['figure.figsize'] = [12,8]

ratio = [6, 15.2, 29.6, 29.4, 14.4, 3.7, 1.7]
categories = ['10대', '20대', '30대', '40대', '50대', '60대', '70대 이상']
group_colors = ['yellowgreen', 'lightskyblue', 'lightcoral', 'lightred']
plt.pie(ratio, labels=categories, autopct='%0.1f%%')

plt.show()

plt.pie(ratio, 
        labels=categories, 
        colors=group_colors, 
        autopct='%1.1f%%', # second decimal place
        shadow=True, 
        startangle=90,
        textprops={'fontsize': 14}) # text font size

plt.axis('equal') #  equal length of X and Y axis

plt.title('Pie Chart of Market Share', fontsize=20)

plt.show()



출처: https://rfriend.tistory.com/412 [R, Python 분석과 프로그래밍의 친구 (by R Friend)]