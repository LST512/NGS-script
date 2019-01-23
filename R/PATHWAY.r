# PATHWAY
rm(list=ls())
setwd("~/data/lst_data/AN3661/raw_data/DEPAC/GO/DAVIDGO")
library(ggplot2)
#------------------------------------
# 柱状图
#------------------------------------
# 设置好工作路径
# 读数据
pathway=read.table("pathway_depac_up.tsv",header=T,sep="\t")
# 初始化数据
pathbar = ggplot(pathway,aes(x=Pathway,y=-1*log10(PValue)))
# 绘制柱形图
pathbar + geom_bar(stat="identity")
# 改变柱子方向
pathbar + geom_bar(stat="identity") + coord_flip()

# 改变填充颜色和边框颜色
pathbar+geom_bar(stat="identity",color="red",fill="blue")+coord_flip()

# 用Qvalue来作为填充颜色
pathbar+geom_bar(stat="identity",aes(fill=-1*log10(PValue)))+coord_flip()
## 按照输入数据的顺序去画柱子
# 生成一个因子向量，记录原始的pathway顺序
porder=factor(as.integer(rownames(pathway)),labels=pathway$Pathway)

# 根据因子向量中的Pathway顺序来绘制柱状图 
pathbar+geom_bar(stat="identity",aes(x=porder,fill=-1*log10(PValue)))+coord_flip()

# 通过rev函数将Pathway的顺序颠倒过来
pathbar+geom_bar(stat="identity",aes(x=rev(porder),fill=-1*log10(rev(PValue)))+coord_flip()

# 正确的做法
porder=factor(as.integer(rownames(pathway)),labels=rev(pathway$Pathway))
pathbar+geom_bar(stat="identity",aes(x=rev(porder),fill=-1*log10(PValue)))+coord_flip()

# 去掉图例
pathbar+geom_bar(stat="identity",aes(x=rev(porder),fill=-1*log10(rev(PValue))))+coord_flip()+theme(legend.position="none")

# 设置标题和坐标轴标题
pqbar=pathbar+geom_bar(stat="identity",aes(x=rev(porder),fill=-1*log10(PValue)))+coord_flip()+theme(legend.position="none")+ labs(title="",y=expression(-log[10](PValue)))

# 添加阈值线
# 注意coord_flip()，所以这里为geom_hline()而不是geom_vline()
pqbar+geom_hline(yintercept=2,color=c("red"),linetype=4)
pqbar+geom_hline(yintercept=c(1.3,2),color=c("darkred","red"),linetype=4)
