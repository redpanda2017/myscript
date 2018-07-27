###############
一个R画图脚本
按照分类，定义不同的颜色
分类指定一定的顺序
###############

library(RColorBrewer)
#自定义颜色条，有30种颜色可用
#newpalette<-colorRampPalette(brewer.pal(9,"Blues"))(10)
newpalette<-colorRampPalette(c("white","lightblue","green", "orange","red"))( 30 )
#barplot(1:30,col=newpalette)
#读取数据，由于有中文，所以需要fileEncoding="utf-8"参数
data<-read.table('result.txt',header=T, fileEncoding="utf-8",sep='\t')
#使用factor函数，固定fresh1列的levels顺序
data$fresh1<-factor(data$fresh1,levels=c("未检出","检出","低","中","高"))
#颜色函数，用来确定每个值使用的相应的颜色
getcol<-function(value){
	if(value == "未检出"){color = newpalette[1]}
	else if(value == "检出"){color = newpalette[3]}
	else if(value == "低"){color = newpalette[6]}
	else if(value == "中"){color = newpalette[18]}
	else if(value == "高"){color = newpalette[25]}
	else {color = "black"}
	return(color)
}
#输出pdf，由于需要输出中文，需要family="GB1参数
pdf("meta.pdf",family="GB1",height=10,width=9)
#定义画布：有两个图，第一个图占1/10，第二图占9/10，两个图竖排
mat<-matrix(c(1,2,2,2,2,2,2,2,2,2),nrow=10,byro=TRUE)
layout(mat)
#定义第一个图的边界
par(mar=c(1,1,1,1))
#第一个图用来画图例，先画一个空白图，定义好坐标
plot(1,1,xlim=c(-15,8),ylim=c(1,15),xlab="",ylab="",yaxt = "n",xaxt="n",pch="",axes=FALSE)
#使用barplot展示图例，注意add参数
barplot(c(1,1,1,1,1),col=newpalette[c(1,3,6,18,25)],space=0,yaxt = "n",add=TRUE,border="gray")
axis(1,at=c(1:5)-0.5,labels=c("未检出","检出","低","中","高"),cex.axis=0.75,las=2,pos=0,cex=0.5,col="gray")

#定义第二个图的边界
par(mar=c(4,4,1,1))
target=0
sample<-ncol(data)
#确定第二个图的边界，画标签
plot(1,1,xlim=c(-2,27),ylim=c(-1,115),xlab="",ylab="",yaxt = "n",xaxt="n",pch="",axes=FALSE)
axis(1,at=1:7,labels=colnames(data)[2:8],cex.axis=0.75,las=2,pos=0,cex=0.35,col="gray")
axis(1,at=9:15,labels=colnames(data)[9:15],cex.axis=0.75,las=2,pos=0,cex=0.35,col="gray")
axis(1,at=17:23,labels=colnames(data)[16:22],cex.axis=0.75,las=2,pos=0,cex=0.35,col="gray")

#数据分七组，循环来画
Antibiotic<-data[(1:17),]
#数据按fresh1列排序，注意，fresh1的顺序在line14，使用factor函数固定
Antibiotic<-Antibiotic[order(Antibiotic$fresh1),]
target<- nrow(Antibiotic)
axis(2,at=1:17,labels=Antibiotic$target,cex.axis=0.5,las=1,pos=0.75,cex=1,col="gray")
for (j in 1:target) {for (i in 2:8){rect(i-1.5,j-0.5,i-0.5,j+0.5,border="gray",col=getcol(Antibiotic[j,i]))}}
for (j in 1:target) {for (i in 9:15){rect(i-1.5+1,j-0.5,i-0.5+1,j+0.5,border="gray",col=getcol(Antibiotic[j,i]))}}
for (j in 1:target) {for (i in 16:22){rect(i-1.5+2,j-0.5,i-0.5+2,j+0.5,border="gray",col=getcol(Antibiotic[j,i]))}}
lines(c(24,24),c(1,17),lwd=2,xpd=TRUE,col="lightblue")
text(c(24,24),mean(c(1,17)),"Antibiotic",xpd=TRUE,pos=4,srt =0,cex=0.7)

Opportunistic_pathogen<-data[(18:47),]
Opportunistic_pathogen<-Opportunistic_pathogen[order(Opportunistic_pathogen$fresh1),]
target<- nrow(Opportunistic_pathogen) 
axis(2,at=c(18:47)+2,labels=Opportunistic_pathogen$target,cex.axis=0.5,las=1,pos=0.75,cex=1,col="gray")
for (j in 1:target) {for (i in 2:8){rect(i-1.5,j-0.5+19,i-0.5,j+0.5+19,border="gray",col=getcol(Opportunistic_pathogen[j,i]))}}
for (j in 1:target) {for (i in 9:15){rect(i-1.5+1,j-0.5+19,i-0.5+1,j+0.5+19,border="gray",col=getcol(Opportunistic_pathogen[j,i]))}}
for (j in 1:target) {for (i in 16:22){rect(i-1.5+2,j-0.5+19,i-0.5+2,j+0.5+19,border="gray",col=getcol(Opportunistic_pathogen[j,i]))}}
lines(c(24,24),c(18,47)+2,lwd=2,xpd=TRUE,col="lightblue")
text(c(24,24),mean(c(18,47)+2),"Opportunistic_pathogen",xpd=TRUE,pos=4,srt =0,cex=0.7)

Probiotics<-data[(48:74),]
Probiotics<-Probiotics[order(Probiotics$fresh1),]
target<- nrow(Probiotics) 
axis(2,at=c(48:74)+4,labels=Probiotics$target,cex.axis=0.5,las=1,pos=0.75,cex=1,col="gray")
for (j in 1:target) {for (i in 2:8){rect(i-1.5,j-0.5+51,i-0.5,j+0.5+51,border="gray",col=getcol(Probiotics[j,i]))}}
for (j in 1:target) {for (i in 9:15){rect(i-1.5+1,j-0.5+51,i-0.5+1,j+0.5+51,border="gray",col=getcol(Probiotics[j,i]))}}
for (j in 1:target) {for (i in 16:22){rect(i-1.5+2,j-0.5+51,i-0.5+2,j+0.5+51,border="gray",col=getcol(Probiotics[j,i]))}}
lines(c(24,24),c(48,74)+4,lwd=2,xpd=TRUE,col="lightblue")
text(c(24,24),mean(c(48,74)+4),"Probiotics",xpd=TRUE,pos=4,srt =0,cex=0.7)

Disease<-data[(75:84),]
Disease<-Disease[order(Disease$fresh1),]
target<- nrow(Disease) 
axis(2,at=c(75:84)+6,labels=Disease$target,cex.axis=0.5,las=1,pos=0.75,cex=1,col="gray")
for (j in 1:target) {for (i in 2:8){rect(i-1.5,j-0.5+80,i-0.5,j+0.5+80,border="gray",col=getcol(Disease[j,i]))}}
for (j in 1:target) {for (i in 9:15){rect(i-1.5+1,j-0.5+80,i-0.5+1,j+0.5+80,border="gray",col=getcol(Disease[j,i]))}}
for (j in 1:target) {for (i in 16:22){rect(i-1.5+2,j-0.5+80,i-0.5+2,j+0.5+80,border="gray",col=getcol(Disease[j,i]))}}
lines(c(24,24),c(75,84)+6,lwd=2,xpd=TRUE,col="lightblue")
text(c(24,24),mean(c(75,84)+6),"Disease",xpd=TRUE,pos=4,srt =0,cex=0.7)

Shannon_index<-data[85,]
Shannon_index<-Shannon_index[order(Shannon_index$fresh1),]
target<- nrow(Shannon_index) 
axis(2,at=c(85)+8,labels=Shannon_index$target,cex.axis=0.5,las=1,pos=0.75,cex=1,col="gray")
for (j in 1:target) {for (i in 2:8){rect(i-1.5,j-0.5+92,i-0.5,j+0.5+92,border="gray",col=getcol(Shannon_index[j,i]))}}
for (j in 1:target) {for (i in 9:15){rect(i-1.5+1,j-0.5+92,i-0.5+1,j+0.5+92,border="gray",col=getcol(Shannon_index[j,i]))}}
for (j in 1:target) {for (i in 16:22){rect(i-1.5+2,j-0.5+92,i-0.5+2,j+0.5+92,border="gray",col=getcol(Shannon_index[j,i]))}}
lines(c(24,24),c(85,85)+8,lwd=2,xpd=TRUE,col="lightblue")
text(c(24,24),mean(c(85)+8),"Shannon_index",xpd=TRUE,pos=4,srt =0,cex=0.7)

Function<-data[(86:95),]
Function<-Function[order(Function$fresh1),]
target<- nrow(Function) 
axis(2,at=c(86:95)+10,labels=Function$target,cex.axis=0.5,las=1,pos=0.75,cex=1,col="gray")
for (j in 1:target) {for (i in 2:8){rect(i-1.5,j-0.5+95,i-0.5,j+0.5+95,border="gray",col=getcol(Function[j,i]))}}
for (j in 1:target) {for (i in 9:15){rect(i-1.5+1,j-0.5+95,i-0.5+1,j+0.5+95,border="gray",col=getcol(Function[j,i]))}}
for (j in 1:target) {for (i in 16:22){rect(i-1.5+2,j-0.5+95,i-0.5+2,j+0.5+95,border="gray",col=getcol(Function[j,i]))}}
lines(c(24,24),c(86,95)+10,lwd=2,xpd=TRUE,col="lightblue")
text(c(24,24),mean(c(86,95)+10),"Function",xpd=TRUE,pos=4,srt =0,cex=0.7)

All<-data[96,]
All<-All[order(All$fresh1),]
target<- nrow(All) 
axis(2,at=c(96)+12,labels=All$target,cex.axis=0.5,las=1,pos=0.75,cex=1,col="gray")
for (j in 1:target) {for (i in 2:8){rect(i-1.5,j-0.5+107,i-0.5,j+0.5+107,border="gray",col=getcol(All[j,i]))}}
for (j in 1:target) {for (i in 9:15){rect(i-1.5+1,j-0.5+107,i-0.5+1,j+0.5+107,border="gray",col=getcol(All[j,i]))}}
for (j in 1:target) {for (i in 16:22){rect(i-1.5+2,j-0.5+107,i-0.5+2,j+0.5+107,border="gray",col=getcol(All[j,i]))}}
lines(c(24,24),c(96,96)+12,lwd=2,xpd=TRUE,col="lightblue")
text(c(24,24),mean(c(96)+12),"All",xpd=TRUE,pos=4,srt =0,cex=0.7)
dev.off()

