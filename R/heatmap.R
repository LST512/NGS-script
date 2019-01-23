# learn to plot heatmap
#lst
#date :2018-4-3
# heatmap
# scale函数是将一组数进行处理，默认情况下是将一组数的每个数都减去这组数的平均值后再除以这组数的均方根。
#其中有两个参数，center=TRUE，默认的，是将一组数中每个数减去平均值，若为false，则不减平均值
#colorRampPalett 创建颜色梯度，渐变色,c("blue", "red") 指的是颜色从蓝色渐变到红色，5 代表创建长度为5的颜色梯度
# edition1
rm(list = ls())
install.packages("car")
library(car)
df <- as.matrix(scale(mtcars))
col <- colorRampPalette(c('red','yellow','blue'))(256)
heatmap(df, scale = 'col', col=col)
# edition 2
# Use RColorBrewer color palette names
rm(list = ls())
#install.packages("RColorBrewer")
library(RColorBrewer)
library(car)
df <- as.matrix(scale(mtcars))
# RowSidecolor与ColSideColor用于行和列的颜色
col <- colorRampPalette(brewer.pal(10, 'RdYlBu'))(256)
# 双引号，单引号会提示问题
heatmap(df, scale = "none", col=col, RowSideColors = rep(c("blue", "pink"), each=16), ColSideColor = c(rep("purple", 5), rep("orange", 6)))
# edition3
# gplots,增强型热图,heatmap.2()
rm(list = ls())
#install.packages("gplots")
library(gplots)
# help("heatmap.2")
library(car)
df <- as.matrix(scale(mtcars))
#bluered
heatmap.2(df, scale = 'none', col=redgreen(75), trace = "none", key = TRUE, density.info = "none")
