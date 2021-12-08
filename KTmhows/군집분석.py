# -*- coding: utf-8 -*-
"""
Created on Tue Oct 20 16:47:49 2020

@author: CPB10N
"""


import numpy as np
import pandas as pd

import matplotlib.pyplot as plt
import seaborn as sns
plt.style.use('seaborn')

import warnings
warnings.filterwarnings('ignore')

df = pd.read_excel("C:/BigData/projects/mhows_b2c/clustering.xlsx")
df
df.head()
df.shape
df = df.iloc[:, 1:]

df.describe()

from sklearn.preprocessing import StandardScaler

standard_scaler = StandardScaler()
scaled_df = pd.DataFrame(standard_scaler.fit_transform(df), columns=df.columns)


#hierarchy
from scipy.cluster.hierarchy import linkage, dendrogram

linkage_list = ['single', 'complete', 'average', 'centroid', 'ward']
data = [df, scaled_df]


fig, axes = plt.subplots(nrows=len(linkage_list), ncols=2, figsize=(16, 35))
for i in range(len(linkage_list)):
    for j in range(len(data)):
        hierarchical_single = linkage(data[j], method=linkage_list[i])
        dn = dendrogram(hierarchical_single, ax=axes[i][j])
        axes[i][j].title.set_text(linkage_list[i])
plt.show()


from sklearn.cluster import AgglomerativeClustering
agg_clustering = AgglomerativeClustering(n_clusters=5, linkage='average')
labels = agg_clustering.fit_predict(df)





##############################




df = pd.read_excel("C:/BigData/projects/mhows_b2c/clust.xlsx")
df
df.head()
df.shape
df = df.iloc[:, 1:]

df.describe()


## 표준화

from sklearn.preprocessing import StandardScaler

# Rescale the data to zero mean and unit variance
standard_scaler = StandardScaler()
scaled_df = pd.DataFrame(standard_scaler.fit_transform(df), columns=df.columns)

print(scaled_df)


# plot scatter of moon set
sns.lmplot(x = '전전년대비 매출성장률(전년-전전년/전전년)', y = '언론사 노출 빈도수', 
           data = scaled_df, fit_reg = False)


## DBSCAN
from sklearn.cluster import DBSCAN

dbscan = DBSCAN(eps = 0.5, min_samples = 5, metric='euclidean')
dbscan.fit(scaled_df)

scaled_df['DBSCAN Cluster Labels'] = dbscan.labels_

from matplotlib import font_manager, rc
font_name = font_manager.FontProperties(fname="c:/Windows/Fonts/malgun.ttf").get_name()
rc('font', family=font_name)

sns.lmplot(x = '언론사 노출 빈도수', y = '전전년대비 매출성장률(전년-전전년/전전년)', 
           hue = "DBSCAN Cluster Labels", data = scaled_df, fit_reg = False)

model = dbscan
visualizer = KElbowVisualizer(model, k=(1,20))
visualizer.fit(X)


## k-means 
from sklearn.cluster import KMeans

kmeans = KMeans(n_clusters = 4)
kmeans.fit(scaled_df)
scaled_df['KMeans Cluster Labels'] = kmeans.labels_


font_name = font_manager.FontProperties(fname="c:/Windows/Fonts/malgun.ttf").get_name()
rc('font', family=font_name)

sns.lmplot(x = '언론사 노출 빈도수', y = '전전년대비 매출성장률(전년-전전년/전전년)',
          hue = "KMeans Cluster Labels", data = scaled_df, fit_reg = False)


from sklearn.cluster import KMeans
pip install yellowbrick
from yellowbrick.cluster.elbow import kelbow_visualizer
from yellowbrick.datasets.loaders import load_nfl

X, y = load_nfl()

from yellowbrick.cluster import KElbowVisualizer

model = kmeans
visualizer = KElbowVisualizer(model, k=(1,20))
visualizer.fit(X)


