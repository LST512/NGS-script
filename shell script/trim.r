# 去除文件中特定列的某些字符
# 去除PAC表中gene所在列的igt文件
# lst
rm(list=ls())
setwd("~/Desktop/bowtie2_data/global_APA")
test_file <- read.table(file = "test.txt")
# method 1
# a1 <- test_file[,-16] #去除igt所在的列，第16列,复制给a1
# data.frame(a1)
# a2 <- gsub(".igt","",test_file[,16]) #去除第16列的igt
# data1 <- data.frame(a2,a1)　#重构数据
# write.csv(data1,"test_trim_igt.csv")

# PAC表一共33列，要处理的为第16列
#　把文件分三份，1-15 16 17-33
# 对17列进行处理，替换.igt
# 最后合并文件
a1 <- test_file[,c(1:15)]
a2 <- gsub(".igt","",test_file[,16])
a3 <- test_file[,c(17:33)]
data_all <- data.frame(a1,a2,a3) #重新构造
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