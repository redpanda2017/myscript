import urllib
from urllib import request
import re

#获得下载路径
def getpath(html):
	for i in html.split('\n'):
		if(re.search(r'Series Matrix File',i)):
			path=re.search(r'ftp:.*matrix/',i).group()
			return path

#获得下载文件名称
def getfile(html):
	files = []
	for i in html.split('\n'):
		if(re.search(r'GSE.*gz',i)):
			files.append(re.search(r'GSE.*?gz',i).group())
	return files

'''
GSE文件格式如下：

GSE41037
GSE41169
GSE40279
GSE36064
GSE32149
GSE27317
GSE38873
GSE15745
GSE15745
GSE15745


'''

#读取GEO数据库的ID列表 
with open ('GSE.list', 'r') as f:
	for line in f.readlines():
		line = line.strip()
		url="https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=" + line
		response = urllib.request.urlopen(url)
		html = response.read().decode('utf-8')
		path = getpath(html)
		response2 = urllib.request.urlopen(path)
		html2 = response2.read().decode('utf-8')
		files = getfile(html2)
		for file_sub in files:
			filepath = path + file_sub + '\n'
			with open('path.list', 'a+') as f:
				f.write(filepath)
