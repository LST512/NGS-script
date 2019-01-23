# switch gene
# ABS(0.1,0.15,0.2)
######
setwd("/home/lst/Desktop/")
# raw data do switch
# ck
rm(list = ls())
raw_data = read.table(file = "/home/lst/Desktop/raw_AN.csv", sep = ",", header = T, row.names = 1)
head(raw_data)
ck <- raw_data[,c("gene","col_mean")]
head(ck)
gene_sum <- tapply(ck$col_mean,ck$gene,sum)
head(gene_sum)
genes <- attr(gene_sum,'dimnames')
genes <- genes[[1]]
for (i in 1:length(genes)) {
  idx = which(as.character(ck$gene)==genes[i])
  ck$col_mean[idx] = ck$col_mean[idx]/gene_sum[i]
}
nrow(ck)
colnames(ck)=c("gene","col0.frac")
col0_frac=cbind(raw_data,ck$col0.frac)
nrow(col0_frac)
nrow(raw_data)
head(col0_frac)
write.csv(col0_frac,file = "col_switch.csv")
########
# AN3661
rm(list = ls())
raw_data = read.table(file = "/home/lst/Desktop/col_switch.csv", sep = ",", header = T, row.names = 1)
head(raw_data)
AN3661 = raw_data[,c("gene", "AN_mean")]
head(AN3661)
gene_sum = tapply(AN3661$AN_mean, AN3661$gene, sum)
head(gene_sum)
genes <- attr(gene_sum,'dimnames')
genes <- genes[[1]]
for (i in 1:length(genes)) {
 idx = which(as.character(AN3661$gene)==genes[i])
 AN3661$AN_mean[idx] = AN3661$AN_mean[idx]/gene_sum[i]
}
nrow(AN3661)
head(AN3661)
colnames(AN3661)=c("gene","AN.frac")
AN_frac=cbind(raw_data,AN3661$AN.frac)
nrow(AN_frac)
nrow(raw_data)
head(AN_frac)
write.csv(AN_frac,file = "raw_AN3661_col0_switch_gene.csv")
#####################################################################################
#DESeq2 results do switch
# ck
rm(list = ls())
raw_data = read.table(file = "/home/lst/Desktop/AN3661_col0_DEseq2.csv", sep = ",", header = T, row.names = 1)
head(raw_data)
ck <- raw_data[,c("gene","col_mean")]
head(ck)
gene_sum <- tapply(ck$col_mean,ck$gene,sum)
head(gene_sum)
genes <- attr(gene_sum,'dimnames')
genes <- genes[[1]]
for (i in 1:length(genes)) {
  idx = which(as.character(ck$gene)==genes[i])
  ck$col_mean[idx] = ck$col_mean[idx]/gene_sum[i]
}
nrow(ck)
colnames(ck)=c("gene","col0.frac")
col0_frac=cbind(raw_data,ck$col0.frac)
nrow(col0_frac)
nrow(raw_data)
head(col0_frac)
write.csv(col0_frac,file = "DE_col_switch.csv")

# AN3661
rm(list = ls())
raw_data = read.table(file = "/home/lst/Desktop/DE_col_switch.csv", sep = ",", header = T, row.names = 1)
head(raw_data)
AN3661 = raw_data[,c("gene", "AN_mean")]
head(AN3661)
gene_sum = tapply(AN3661$AN_mean, AN3661$gene, sum)
head(gene_sum)
genes <- attr(gene_sum,'dimnames')
genes <- genes[[1]]
for (i in 1:length(genes)) {
  idx = which(as.character(AN3661$gene)==genes[i])
  AN3661$AN_mean[idx] = AN3661$AN_mean[idx]/gene_sum[i]
}
nrow(AN3661)
head(AN3661)
colnames(AN3661)=c("gene","AN.frac")
AN_frac=cbind(raw_data,AN3661$AN.frac)
nrow(AN_frac)
nrow(raw_data)
head(AN_frac)
write.csv(AN_frac,file = "DE_AN3661_col0_switch_gene.csv")







