# DEG analysis
# 2018-9-13更新
# source("http://bioconductor.org/biocLite.R")
rm(list = ls())
#设置工作目录
#setwd('/home/lst/Desktop/ss/')
##############
#基本功能分析
#############
library(RColorBrewer)
library(calibrate)
library(genefilter)
library(DESeq2)
library(gplots)
data_all = read.table(file = "/home/lst/Desktop/ss/Deseq2_results/ss_data.csv", sep = ",", header = T, row.names = 1)
database = data_all[,c(7:9, 4:6)]
head(database)
########
contrast_label = c("condition","dehy_24h","dehy_1h") #画图方便调用
group_list = c('dehy_24h','dehy_24h','dehy_24h','dehy_1h','dehy_1h','dehy_1h') #画图方便调用
levels_label = c( "dehy_24h","dehy_1h")
factor_label = c(rep("dehy_24h" ,3), rep("dehy_1h", 3))
########
condition = factor(factor_label, levels = levels_label) #画图方便调用
countdata = round(as.matrix(database))
coldata = data.frame(row.names = colnames(countdata), condition)
dds = DESeqDataSetFromMatrix(countdata, colData = coldata, design = ~ condition)
#dds = dds[ rowSums(counts(dds))>1, ] #过滤掉那些 count 结果都为 0 的数据，这些没有表达的基因对结果的分析没有用
dds = DESeq(dds)
head(dds)
#查看每个样本的标准化因子
sizeFactors(dds)
res_plot = results(dds) #画图用
res <- results(dds,contrast = contrast_label)
#res <- res[order(res$padj),]
resdata <- merge(as.data.frame(res), as.data.frame(counts(dds, normalized=TRUE)),by="row.names",sort=FALSE)
diff_gene_pac <- subset(resdata, padj < 0.05 & (log2FoldChange > 1 | log2FoldChange < -1))
up_gene_pac = subset(resdata, padj < 0.05 & (log2FoldChange > 1))
down_gene_pac = subset(resdata, padj < 0.05 & (log2FoldChange < -1))
write.csv(resdata,file = "DEseq2_all_normalized.csv")
write.csv(diff_gene_pac,file = "DEseq2_diff_gene_pac.csv")
write.csv(up_gene_pac,file = "DEseq2_up_gene_pac.csv")
write.csv(down_gene_pac,file = "DEseq2_down_gene_pac.csv")
#####################
# 获得normalized的数据
#####################
normalizedCounts <- counts(dds, normalized=T) # normalized
#normalizedCounts1 <- t( t(counts(dds)) / sizeFactors(dds)) # it's the same for the tpm value
head(normalizedCounts) 
exprMatrix=as.data.frame(normalizedCounts) 
head(exprMatrix)
rld <- rlogTransformation(dds) #regularized log transformation,耗时
exprMatrix_rlog=assay(rld) #regularized log transformation
write.csv(exprMatrix,'exprMatrix.csv' )
write.csv(exprMatrix_rlog,'exprMatrix.rlog.csv' )

##################
# 画相关图
#################
# plot DispEsts (dispersion estimates)
png("qc_dispersions.png", 1000, 1000, pointsize=20)
plotDispEsts(dds, main="Dispersion plot")
dev.off()


# raw reads与归一化后的reads比较
png("DEseq_RAWvsNORM.png",height = 1000,width = 1000)
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


#第一种PCA分析
#可视化样本-样本距离的方法
png("PCA1.png", w=800, h=500, pointsize=30)
plotPCA(rld,intgroup=c("condition"))
dev.off()
#第二种PCA分析
#group_list=c('AN','AN','AN','ct','ct','ct')
mycols <- brewer.pal(8, "Dark2")[1:length(unique(group_list))]
rld_pca <- function (rld, intgroup = "condition", ntop = 500, colors=NULL, legendpos="bottomleft", main="PCA analysis", textcx=1, ...) {
  require(genefilter)
  require(calibrate)
  require(RColorBrewer)
  rv = rowVars(assay(rld))
  select = order(rv, decreasing = TRUE)[seq_len(min(ntop, length(rv)))]
  pca = prcomp(t(assay(rld)[select, ]))
  fac = factor(apply(as.data.frame(colData(rld)[, intgroup, drop = FALSE]), 1, paste, collapse = " : "))
  if (is.null(colors)) {
    if (nlevels(fac) >= 3) {
      colors = brewer.pal(nlevels(fac), "Paired")
    }   else {
      colors = c("black", "red")
    }
  }
  pc1var <- round(summary(pca)$importance[2,1]*100, digits=1)
  pc2var <- round(summary(pca)$importance[2,2]*100, digits=1)
  pc1lab <- paste0("PC1 (",as.character(pc1var),"%)")
  pc2lab <- paste0("PC2 (",as.character(pc2var),"%)")
  plot(PC2~PC1, data=as.data.frame(pca$x), bg=colors[fac], pch=21, xlab=pc1lab, ylab=pc2lab, main=main, ...)
  with(as.data.frame(pca$x), textxy(PC1, PC2, labs=rownames(as.data.frame(pca$x)), cex=textcx))
  legend(legendpos, legend=levels(fac), col=colors, pch=20)
  #     rldyplot(PC2 ~ PC1, groups = fac, data = as.data.frame(pca$rld),
  #            pch = 16, cerld = 2, aspect = "iso", col = colours, main = draw.key(key = list(rect = list(col = colours),
  #                                                                                         terldt = list(levels(fac)), rep = FALSE)))
}
png("PCA2.png", 1000, 1000, pointsize=20)
rld_pca(rld, colors=mycols, intgroup="condition", xlim=c(-200,90))
dev.off()


#评估样本间的总体相似度
# 那些样本最接近
# 那些样本差异较大
# 这与实验设计预期符合么
# 使用R内置的 dist 计算 rlog变换数据的Euclidean distance，然后用pheatmap根据结果画热图
#group_list=c('AN','AN','AN','ct','ct','ct')
mycols <- brewer.pal(8, "Dark2")[1:length(unique(group_list))]
cor(as.matrix(countdata))
# Sample distance heatmap
sampleDists <- as.matrix(dist(t(exprMatrix_rlog)))
png("heatmap-samples.png", w=1000, h=1000, pointsize=20)
heatmap.2(as.matrix(sampleDists), key=F, trace="none",
          col=colorpanel(100, "black", "white"),
          ColSideColors=mycols[group_list], RowSideColors=mycols[group_list],
          margin=c(10, 10), main="Sample Distance Matrix")
dev.off()


#看看padj值最小基因的count数量
res_count <- results(dds,contrast = contrast_label)
topGene <- rownames(res_count)[which.min(res_count$padj)]
png("counts_of_padj.png", w=1000, h=1000, pointsize=20)
plotCounts(dds, gene = topGene, intgroup=c("condition"))
dev.off()

#MA-plot了解模型（如所有基因在不同处理比较的结果）的估计系数的分布
#mean-difference plot,Bland-Altman plot
#M means log fold change, A means the count mean
# maplot1
png("MAplot1.png", w=1000, h=1000, pointsize=20)
plotMA(res, main="DEseq2", ylim = c(-5, 5))
dev.off()
#maplot by shrink
res_count <- results(dds,contrast = contrast_label)
topGene <- rownames(res_count)[which.min(res_count$padj)]
res.shrink <- lfcShrink(dds, contrast=contrast_label, res=res_plot) #耗时
png("MAplot2.png", w=1000, h=1000, pointsize=20)
plotMA(res.shrink, main="DEseq2", ylim = c(-5, 5))
with(res_count[topGene, ], {
  points(baseMean, log2FoldChange, col="dodgerblue", cex=2, lwd=2)
  text(baseMean, log2FoldChange, topGene, pos=2, col="dodgerblue")
})
dev.off()


#在图片上画出特定阈值的基因
maplot <- function (res, thresh=0.001, FC=4, labelsig=TRUE, textcx=1, ...) {
  with(res, plot(baseMean, log2FoldChange, pch=20, cex=.5, log="x", ...))
  with(subset(res, padj<thresh & abs(log2FoldChange)>FC), points(baseMean, log2FoldChange, col="red", pch=20, cex=1.5))
  if (labelsig) {
    require(calibrate)
    with(subset(res, padj<thresh & abs(log2FoldChange)>FC), textxy(baseMean, log2FoldChange, labs=Row.names, cex=textcx, col=2))
  }
}
png("diff_expr_maplot.png", 1500, 1000, pointsize=20)
maplot(resdata, main="MA Plot", ylim=c(-5, 5))
dev.off()


#基因聚类所提供的热图展示
#30 most highly expressed genes
#Heatmap of the count table
#library("RColorBrewer")
#library("gplots")
select <- order(rowMeans(counts(dds,normalized=TRUE)),decreasing=TRUE)[1:10]
hmcol <- colorRampPalette(brewer.pal(9, "GnBu"))(100)
png("raw_counts_10high.png",height = 1000,width = 1000)
heatmap.2(counts(dds,normalized=TRUE)[select,], col = hmcol,
          Rowv = FALSE, Colv = FALSE, scale="none",
          dendrogram="none", trace="none", margin=c(10,6))
dev.off()

#regularized log transformation
rld <- rlog(dds)
png('rlog_counts10high.png', width = 1000, height = 1000)
heatmap.2(assay(rld)[select,], col = hmcol,
          Rowv = FALSE, Colv = FALSE, scale="none",
          dendrogram="none", trace="none", margin=c(10, 6))
dev.off()


#variance stabilizing transformation
vsd <- varianceStabilizingTransformation(dds)
png('vsd_counts10high.png', width = 1000, height = 1000)
heatmap.2(assay(vsd)[select,], col = hmcol,
          Rowv = FALSE, Colv = FALSE, scale="none",
          dendrogram="none", trace="none", margin=c(10, 6))
dev.off()


#resdata = read.table(file = "/home/lst/Desktop/ss/Deseq2_results/dehy1h_ct/dehy_0h_ct_DEseq2_nor.csv", sep = ",", header = T, row.names = 1)
## Volcano plot with "significant" genes labeled
volcanoplot <- function (res, lfcthresh=1, sigthresh=0.05, main="dehy_1h vs ct", legendpos="bottomright", labelsig=TRUE, textcx=1, ...) {
  with(res, plot(log2FoldChange, -log10(pvalue), pch=20, main=main, ...))
  with(subset(res, padj<sigthresh ), points(log2FoldChange, -log10(pvalue), pch=20, col="red", ...))
  with(subset(res, abs(log2FoldChange)>lfcthresh), points(log2FoldChange, -log10(pvalue), pch=20, col="orange", ...))
  with(subset(res, padj<sigthresh & abs(log2FoldChange)>lfcthresh), points(log2FoldChange, -log10(pvalue), pch=20, col="green", ...))
#   if (labelsig) {
#     require(calibrate)
#     with(subset(res, padj<sigthresh & abs(log2FoldChange)>lfcthresh), textxy(log2FoldChange, -log10(pvalue), labs=Row.names, cex=textcx, ...))
#   }
#   legend(legendpos, xjust=1, yjust=1, legend=c(paste("FDR<",sigthresh,sep=""), paste("|LogFC|>",lfcthresh,sep=""), "both"), pch=20, col=c("red","orange","green"))
 }
png("diffexpr-volcanoplot.png", 1200, 1000, pointsize=20)
volcanoplot(resdata, lfcthresh=1, sigthresh=0.05, textcx=.8, xlim=c(-4, 4), ylim=c(0, 5))
dev.off()
