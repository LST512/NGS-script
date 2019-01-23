####DEgene##########
## AN3661去除了ABM,保留其他
###处理列放在对照列前面########
####  treat  vs   untreat
rm(list=ls())
library(plyr)
library(DESeq2)
DE_GENE = read.table(file = "/home/lst/data/AN3661所有数据/2018-11-28验证/DE-GENE/AN3661_col0_raw_reads.csv", sep = ",", header = T)
head(DE_GENE)
de_gene = ddply(DE_GENE,"gene",numcolwise(sum))
head(de_gene)
write.csv(de_gene,file = "AN3661_DEgene_raw_reads.csv")
#de_gene = read.table(file = "gene_087117_blue.csv", sep = ",", header = T,row.names = 1)
#database = read.table(file = "/home/yangy/gene_ami_24h_dry.csv", sep = ",", header = T,row.names = 1)
data = de_gene
database =data[,c(1,2:7)]
head(database)
rownames(database)<-database[,1]
database <- database[,-1]
head(database)
condition = factor(c(rep("AN3661" ,3), rep("Col0", 3)), levels = c("AN3661", "Col0"))
countdata = round(as.matrix(database))
coldata = data.frame(row.names = colnames(countdata), condition)
dds = DESeqDataSetFromMatrix(countdata, colData = coldata, design = ~ condition)
dds = DESeq(dds)
head(dds)
res <- results(dds, contrast = c("condition", "AN3661", "Col0"))
#resdata <- merge(as.data.frame(res), as.data.frame(counts(dds, normalized=TRUE)),by="row.name",sort=FALSE)
diff_gene <- subset(res, padj < 0.05 & (log2FoldChange > 1 | log2FoldChange < -1))
up_gene = subset(res, padj < 0.05 & (log2FoldChange > 1))
down_gene = subset(res, padj < 0.05 & (log2FoldChange < -1))
head(res)
write.csv(res,file = "DEseq2_all_gene.csv")
write.csv(diff_gene,file = "DEseq2_DEgene.csv")
write.csv(up_gene,file = "DEseq2_DEgene_up.csv")
write.csv(down_gene,file = "DEseq2_DEgene_down.csv")
head(res)
head(diff_gene)


