# DEG analysis
# source("http://bioconductor.org/biocLite.R")
rm(list = ls())
library(DESeq2)
database = read.table(file = "AN3661_col0_raw.csv", sep = ",", header = T, row.names = 1)
database = database[,c(1:3, 4:6)]
head(database)
condition = factor(c(rep("AN_10d" ,3), rep("Col_10d", 3)), levels = c( "AN_10d","Col_10d"))
countdata = round(as.matrix(database))
coldata = data.frame(row.names = colnames(countdata), condition)
dds = DESeqDataSetFromMatrix(countdata, colData = coldata, design = ~ condition)
#过滤掉那些 count 结果都为 0 的数据，这些没有表达的基因对结果的分析没有用
dds = dds[ rowSums(counts(dds))>1, ]
dds = DESeq(dds)
head(dds)
res <- res[order(res$padj),]
res <- results(dds,contrast = c("condition","AN_10d","Col_10d"))
resdata <- merge(as.data.frame(res), as.data.frame(counts(dds, normalized=TRUE)),by="row.names",sort=FALSE)
diff_gene <-subset(resdata, padj < 0.05 & (log2FoldChange > 1 | log2FoldChange < -1))
write.csv(resdata,file = "AN3661_col0_DEseq2.csv")
write.csv(diff_gene,file = "AN3661_col0_DEseq2_diff_gene.csv")
# plot DispEsts (dispersion estimates)
png("qc_dispersions.png", 1000, 1000, pointsize=20)
plotDispEsts(dds, main="Dispersion plot")
dev.off()

rld <- rlogTransformation(dds)
exprMatrix_rlog=assay(rld) 
write.csv(exprMatrix_rlog,'exprMatrix.rlog.csv' )

# normalized
#normalizedCounts1 <- t( t(counts(dds)) / sizeFactors(dds) )
# it's the same for the tpm value
normalizedCounts2 <- counts(dds, normalized=T) 
head(normalizedCounts2)
exprMatrix=as.data.frame(normalizedCounts2) 
head(exprMatrix)
write.csv(exprMatrix,'exprMatrix.csv' )



png("DEseq_RAWvsNORM.png",height = 800,width = 800)
par(cex = 0.7)
n.sample=ncol(countdata)
if(n.sample>40) par(cex = 0.5)
cols <- rainbow(n.sample*1.2)
par(mfrow=c(2,2))
boxplot(countdata, col = cols,main="expression value",las=2)
boxplot(exprMatrix_rlog, col = cols,main="expression value",las=2)
hist(as.matrix(countdata))
hist(exprMatrix_rlog)
dev.off()

#PCA分析
#可视化样本-样本距离的方法
plotPCA(rld,intgroup=c("condition"))
#评估样本间的总体相似度
# 那些样本最接近
# 那些样本差异较大
# 这与实验设计预期符合么
# 使用R内置的 dist 计算 rlog变换数据的Euclidean distance，然后用pheatmap根据结果画热图
library(RColorBrewer)
group_list=c('AN','AN','AN','Col0','Col0','Col0')
(mycols <- brewer.pal(8, "Dark2")[1:length(unique(group_list))])
cor(as.matrix(countdata))
# Sample distance heatmap
sampleDists <- as.matrix(dist(t(exprMatrix_rlog)))
#install.packages("gplots",repos = "http://cran.us.r-project.org")
library(gplots)
png("qc-heatmap-samples.png", w=1000, h=1000, pointsize=20)
heatmap.2(as.matrix(sampleDists), key=F, trace="none",
          col=colorpanel(100, "black", "white"),
          ColSideColors=mycols[group_list], RowSideColors=mycols[group_list],
          margin=c(10, 10), main="Sample Distance Matrix")
dev.off()


#看看特定基因的count数量
#res <- results(dds,contrast = c("condition","AN_10d","Col_10d"))
topGene <- rownames(res)[which.min(res$padj)]
png("AN3661_Col0_MAplot_count.png", w=1000, h=1000, pointsize=20)
plotCounts(dds, gene = topGene, intgroup=c("condition"))
dev.off()

#MA-plot了解模型（如所有基因在不同处理比较的结果）的估计系数的分布
#mean-difference plot,Bland-Altman plot
#M means log fold change, A means the count mean
res <- lfcShrink(dds, contrast=c("condition","AN_10d","Col_10d"), res=res)
png("AN3661_Col0_MAplot.png", w=1000, h=1000, pointsize=20)
plotMA(res, ylim = c(-5, 5))
dev.off()

#基因聚类所提供的热图展示
#前20个样本件差异比较大，然后看他们在不同样本间的表达情况
sum(res$padj < 0.05, na.rm=TRUE)
library("pheatmap")
select <- order(rowMeans(counts(dds, normalized=TRUE)), decreasing=TRUE)[1:100]
nt <- normTransform(dds) # defaults to log2(x+1)
log2.norm.counts <- assay(nt)[select,]
name= c("m_control1", "m_control2", "akap95_1", "akap95_2")
df <- as.data.frame(counts(dds)[,"condition"])
coldata(dds)
pdf('heatmap1000.pdf', width = 6, height = 7)
pheatmap(log2.norm.counts, cluster_rows=TRUE, show_rownames=FALSE, cluster_cols=TRUE, annotation_col=df)
dev.off()

