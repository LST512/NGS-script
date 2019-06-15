# 去除文件中特定列的某些字符
rm(list=ls())
setwd("~/Desktop/bowtie2_data/global_APA")
test_file <- read.table(file = "test.txt")
a1 <- test_file[,c(1:15)]
a2 <- gsub(".igt","",test_file[,16])
a3 <- test_file[,c(17:33)]
data_all <- data.frame(a1,a2,a3)
colnames(data_all) <- c("chr", "strand", "coord", "tot_tagnum", 
                         "AN_10d_1_PAT", "AN_10d_2_PAT", "AN_10d_3_PAT",
                         "Col_10d_1_PAT", "Col_10d_2_PAT", "Col_10d_3_PAT",
                         "gff_id", "ftr", "ftr_start", "ftr_end", "transcript", 
                         "gene", "gene_type", "ftrs", "trspt_cnt", "UPA_start", 
                         "UPA_end", "tot_PAnum", "tot_ftrs", "ref_coord", "ref_tagnum",
                         "anti_gff_id", "anti_strand", "anti_ftr", "anti_ftr_start", "anti_ftr_end",
                         "anti_transcript", "anti_gene", "anti_gene_type")
data_final <- data_all
write.csv(data_final,"test_trim_igt.csv")