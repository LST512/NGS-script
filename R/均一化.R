# DE gene 
# source("http://bioconductor.org/biocLite.R")
rm(list = ls())
library(DESeq2)
data_all = read.table(file = "/home/lst/data/AN3661所有数据/2018-11-28验证/DE-GENE/AN3661_DEgene_raw_reads.csv", sep = ",", header = T, row.names = 1)
database = data_all[,c(5:7, 8:10)]
head(database)
########
contrast_label = c("condition","AN3661","col0") #画图方便调用
group_list = c('AN3661','AN3661','AN3661','col0','col0','col0') #画图方便调用
levels_label = c( "AN3661","col0")
factor_label = c(rep("AN3661" ,3), rep("col0", 3))
main_name = 'AN3661 vs Col0'
########
condition = factor(factor_label, levels = levels_label) #画图方便调用
countdata = round(as.matrix(database))
coldata = data.frame(row.names = colnames(countdata), condition)
dds = DESeqDataSetFromMatrix(countdata, colData = coldata, design = ~ condition)
#dds = dds[ rowSums(counts(dds))>1, ] #过滤掉那些 count 结果都为 0 的数据，这些没有表达的基因对结果的分析没有用
dds = DESeq(dds)
head(dds)
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







