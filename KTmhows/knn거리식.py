# -*- coding: utf-8 -*-
"""
Created on Wed Oct 21 16:55:06 2020

@author: CPB10N
"""
import pandas as pd

df = pd.read_excel("C:/BigData/projects/mhows_b2c/clust.xlsx")
df_t = pd.DataFrame(df)
df.head()
df.shape
df = df_t.iloc[1:, 1:]

df.describe()


#거리 계산
from math import sqrt

def euclidean_distance(row1, row2):
    distance = 0.0
    for i in range(len(row1)-1):
        distance += (row1[i] - row2[i])**2
    return sqrt(distance)

import numpy as np
list_1 = df.values.tolist()

row0 = df_t.iloc[0, 1:]
for row in list_1:
    distance = euclidean_distance(row0, row)
    print(distance)


#근접요소추출
def get_neighbors(train, test_row, num_neighbors):
    distances = list()
    for train_row in train:
        dist = euclidean_distance(test_row, train_row)
        distances.append((train_row, dist))
    distances.sort(key=lambda tup: tup[1])
    neighbors = list()
    for i in range(num_neighbors):
        neighbors.append(distances[i][0])
    return neighbors


neighbors = get_neighbors(list_1, row0, 23)
for neighbor in neighbors:
    print(neighbor)