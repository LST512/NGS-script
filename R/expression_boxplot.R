#lst
#2019-5-31
# 整体的基因表达水平和其他区域switch的基因表达水平
# input为DEseq2_all_gene的表达量，3UTR之间，CDS区域的
rm(list=ls())
setwd("~/Desktop/AN3661/bowtie2_data/global_APA/rplot")
library(ggplot2)
library(vioplot)
gene_expr <- read.csv(file = "DEseq2_all_gene.csv",header = T)
de_data <- subset(gene_expr, padj < 0.05 & (log2FoldChange > 1 | log2FoldChange < -1))
switch_gene <- read.csv(file = "switch_gene_expression.csv",header = T)
threeUtr <- subset(switch_gene,switch_gene$switch_type == "3UTR-3UTR")
CDS <- subset(switch_gene,switch_gene$switch_type == "3UTR-CDS"|
                     switch_gene$switch_type == "CDS-3UTR"|
                     switch_gene$switch_type == "CDS-CDS")
intron_3UTR <- subset(switch_gene,switch_gene$switch_type == "3UTR-intron"|
                        switch_gene$switch_type == "intron-3UTR")
#ks.test(gene_expr$log2FoldChange,de_data$log2FoldChange)
ks.test(gene_expr$log2FoldChange,threeUtr$log2FoldChange)
ks.test(gene_expr$log2FoldChange,CDS$log2FoldChange)
ks.test(gene_expr$log2FoldChange,intron_3UTR$log2FoldChange)

#boxplot(gene_expr$log2FoldChange,de_data$log2FoldChange,
#        names = c("All gene","degene"),col = c("orange","pink"))
#vioplot(gene_expr$log2FoldChange,de_data$log2FoldChange,
#        names = c("All gene","degene"),col = c("orange","pink"),
#        main="D = 0.44499, p-value < 2.2e-16",
#        ylab = "log2(AN3661/Control)")

boxplot(gene_expr$log2FoldChange,switch_gene$log2FoldChange,
        threeUtr$log2FoldChange,CDS$log2FoldChange,
        intron_3UTR$log2FoldChange,
        names = c("All genes","switch genes","3'UTR","CDS","intron"),
        col = c("orange","pink","yellow","gray","green"))

vioplot(gene_expr$log2FoldChange,de_data$log2FoldChange,
        threeUtr$log2FoldChange,CDS$log2FoldChange,
        intron_3UTR$log2FoldChange,
        names = c("All genes","switch genes","3'UTR","CDS","intron"),
        col = c("orange","pink","yellow","gray","green"))
#vioplot(gene_expr$log2FoldChange,de_data$log2FoldChange,
#        names = c("All gene","degene"),col = c("orange","pink"),
#        main="D = 0.44499, p-value < 2.2e-16",
#        ylab = "log2(AN3661/Control)")



