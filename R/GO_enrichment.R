# go enrichment plot
rm(list=ls())
library(ggplot2)
go = read.table("/home/lst/data/AN3661所有数据/画图/depac/agriGO/agriGO_depac_up.csv",header=T,sep=',')
# 画图
p = ggplot(go,aes(GeneRatio,Term))
p=p + geom_point()
# 改变点的大小
p=p + geom_point(aes(size=Count))
# 四维数据的展示
pbubble = p + geom_point(aes(size=Count,color=-1*log10(FDR)))
# 自定义渐变颜色
pbubble =pbubble + scale_colour_gradient(low="green",high="red")
# 绘制pathway富集散点图
pr = pbubble + scale_colour_gradient(low="green",high="red") + 
  labs(color=expression(-log[10](FDR)),
       x="Gene Ratio",y="", title="")
# 改变图片的样式（主题）
pr=pr + theme_bw()
pr

