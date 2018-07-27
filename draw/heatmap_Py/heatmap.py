#!/usr/bin/python3
import matplotlib
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

df = pd.read_table("./genus_abundance.xls")
df.index = df.pop("Sample")
df=df.T
bac=df.index.values
sam=df.columns.values
#定义颜色条
#cdict 定义三原色的起始和终止位置，通过颜色的混合来控制颜色条的变化
cdict = {'red': ((0., 1, 1),
                                 (0.03, 0, 0),
                                 (0.475, 1, 1),
                                 (1, 0.5, 0.5)),
                 'green': ((0., 1, 1),
                                   (0.00000001, 1, 1),
                                   (0.375, 1, 1),
                                   (0.725, 0, 0),
                                   (1, 0, 0)),
                 'blue': ((0., 1, 1),
                                  (0.00000001, 1, 1),
                                  (0.001, 1, 1),
                                  (0.3, 0, 0),
                                  (1, 0, 0))}


#1600000为颜色条划分的数量
my_cmap = matplotlib.colors.LinearSegmentedColormap('my_colormap', cdict, 1600000)
plt.figure(figsize=(14, 10))
plt.pcolor( df.values,cmap=my_cmap,edgecolors="black")
plt.xticks(list(np.arange(0,len(sam))+0.5),list(sam), rotation="vertical", fontsize="x-small")
plt.yticks(list(np.arange(0,len(bac))+0.5),list(bac), rotation="horizontal", fontsize="xx-small")

y=np.linspace(0, len(bac), 100)
for i in np.arange(7,len(sam),7):
	x=np.linspace(i, i, 100)
	plt.plot(x, y , "r")
plt.subplots_adjust(left=0.3, right=0.9, top=0.9, bottom=0.3)
plt.colorbar()
plt.show()
