# clusterprofiler
rm(list=ls())
#source("http://bioconductor.org/biocLite.R")
#options(BioC_mirror="http://mirrors.ustc.edu.cn/bioc/")
#biocLite("org.At.tair.db")
#biocLite("RDAVIDWebService")
#setwd("~/data/AN3661开题/画图")
library(clusterProfiler)
library(org.At.tair.db)
library(enrichplot)
idType("org.At.tair.db")
#--------------------------GO
tair_id = read.table(file = "/home/lst/data/AN3661所有数据/画图/switch gene/switch_gene.csv", sep = ",", header = T)
head(tair_id)
data = tair_id$gene
head(data)
go = enrichGO(data, OrgDb = org.At.tair.db, keyType="TAIR", ont="BP")#CC;BP;MF
#david = enrichDAVID(data, idType = "TAIR_ID", universe = "Gene", david.user =  "clusterfilter@hku.hk")
go
head(go)
#--------------------------KEGG
KEGG = enrichKEGG(data, organism="ath", pvalueCutoff=.1)
KEGG
#
write.csv(go,"AN3661_switch_BP.csv")
write.csv(KEGG,"AN3661_switch_KEGG.csv")
barplot(go)
barplot(KEGG)
dotplot(go, showCategory = 66)
dotplot(KEGG, showCategory = 20)
emapplot(go)
cnetplot(go)
cnetplot(go, foldChange=gene, circular = TRUE, colorEdge = TRUE)
goplot(go)
