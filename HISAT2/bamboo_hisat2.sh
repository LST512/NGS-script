#!/bin/bash
#MosoBamboo RNA-Seq data analysis using hisat2 2018-3-17 LST
reference=/home/polya/bamboo/bamboo_index/hisat2_index/P_heterocycla
data_dir=/home/polya/data/sra-data/bamboo
hisat2 -p 5 -x $reference -U bakPe1200dnR1-2_L1_7923.R1.clean.fastq.gz -S $data_dir/bakPe1200dnR1-2.sam	2>bakPe1200dnR1-2.log
hisat2 -p 5 -x $reference -U bakPe1200upR1-1_L1_A011.R1.clean.fastq.gz -S $data_dir/bakPe1200upR1-1.sam	2>bakPe1200upR1-1.log
hisat2 -p 5 -x $reference -U Pe1200dnR1-3_L1_7924.R1.clean.fastq.gz -S $data_dir/Pe1200dnR1-3.sam 2>Pe1200dnR1-3.log
hisat2 -p 5 -x $reference -U Pe1200mdR1-1_L1_A012.R1.clean.fastq.gz -S $data_dir/Pe1200mdR1-1.sam 2>Pe1200mdR1-1.log
hisat2 -p 5 -x $reference -U Pe1200mdR1-2_L1_7921.R1.clean.fastq.gz -S $data_dir/Pe1200mdR1-2.sam 2>Pe1200mdR1-2.log
hisat2 -p 5 -x $reference -U Pe1200mdR1-3_L1_7922.R1.clean.fastq.gz -S $data_dir/Pe1200mdR1-3.sam 2>Pe1200mdR1-3.log
hisat2 -p 5 -x $reference -U Pe1200upR1-2_L1_7919.R1.clean.fastq.gz -S $data_dir/Pe1200upR1-2.sam 2>Pe1200upR1-2.log
hisat2 -p 5 -x $reference -U Pe1200upR1-3_L1_7920.R1.clean.fastq.gz -S $data_dir/Pe1200upR1-3.sam 2>Pe1200upR1-3.log
hisat2 -p 5 -x $reference -U Pe140dnR1-1_L1_A004.R1.clean.fastq.gz -S $data_dir/Pe140dnR1-1.sam	2>Pe140dnR1-1.log
hisat2 -p 5 -x $reference -U Pe140dnR1-2_L1_A028.R1.clean.fastq.gz -S $data_dir/Pe140dnR1-2.sam	2>Pe140dnR1-2.log
hisat2 -p 5 -x $reference -U Pe140dnR1-3_L1_A029.R1.clean.fastq.gz -S $data_dir/Pe140dnR1-3.sam	2>Pe140dnR1-3.log
hisat2 -p 5 -x $reference -U Pe140mdR1-1_L1_A003.R1.clean.fastq.gz -S $data_dir/Pe140mdR1-1.sam	2>Pe140mdR1-1.log
hisat2 -p 5 -x $reference -U Pe140mdR1-2_L1_A026.R1.clean.fastq.gz -S $data_dir/Pe140mdR1-2.sam	2>Pe140mdR1-2.log
hisat2 -p 5 -x $reference -U Pe140mdR1-3_L1_A027.R1.clean.fastq.gz -S $data_dir/Pe140mdR1-3.sam	2>Pe140mdR1-3.log
hisat2 -p 5 -x $reference -U Pe140upR1-1_L1_A002.R1.clean.fastq.gz -S $data_dir/Pe140upR1-1.sam	2>Pe140upR1-1.log
hisat2 -p 5 -x $reference -U Pe140upR1-2_L1_A024.R1.clean.fastq.gz -S $data_dir/Pe140upR1-2.sam	2>Pe140upR1-2.log
hisat2 -p 5 -x $reference -U Pe140upR1-3_L1_7911.R1.clean.fastq.gz -S $data_dir/Pe140upR1-3.sam	2>Pe140upR1-3.log
hisat2 -p 5 -x $reference -U Pe22mixR1-1_L1_A001.R1.clean.fastq.gz -S $data_dir/Pe22mixR1-1.sam	2>Pe22mixR1-1.log
hisat2 -p 5 -x $reference -U Pe22mixR1-2_L1_A022.R1.clean.fastq.gz -S $data_dir/Pe22mixR1-2.sam	2>Pe22mixR1-2.log
hisat2 -p 5 -x $reference -U Pe22mixR1-3_L1_7910.R1.clean.fastq.gz -S $data_dir/Pe22mixR1-3.sam	2>Pe22mixR1-3.log
hisat2 -p 5 -x $reference -U Pe350dnR1-1_L1_A007.R1.clean.fastq.gz -S $data_dir/Pe350dnR1-1.sam	2>Pe350dnR1-1.log
hisat2 -p 5 -x $reference -U Pe350dnR1-2_L1_7913.R1.clean.fastq.gz -S $data_dir/Pe350dnR1-2.sam	2>Pe350dnR1-2.log
hisat2 -p 5 -x $reference -U Pe350dnR1-3_L1_A035.R1.clean.fastq.gz -S $data_dir/Pe350dnR1-3.sam	2>Pe350dnR1-3.log
hisat2 -p 5 -x $reference -U Pe350mdR1-1_L1_A006.R1.clean.fastq.gz -S $data_dir/Pe350mdR1-1.sam	2>Pe350mdR1-1.log
hisat2 -p 5 -x $reference -U Pe350mdR1-2_L1_7912.R1.clean.fastq.gz -S $data_dir/Pe350mdR1-2.sam	2>Pe350mdR1-2.log
hisat2 -p 5 -x $reference -U Pe350mdR1-3_L1_A033.R1.clean.fastq.gz -S $data_dir/Pe350mdR1-3.sam	2>Pe350mdR1-3.log
hisat2 -p 5 -x $reference -U Pe350upR1-1_L1_A005.R1.clean.fastq.gz -S $data_dir/Pe350upR1-1.sam	2>Pe350upR1-1.log
hisat2 -p 5 -x $reference -U Pe350upR1-2_L1_A030.R1.clean.fastq.gz -S $data_dir/Pe350upR1-2.sam	2>Pe350upR1-2.log
hisat2 -p 5 -x $reference -U Pe350upR1-3_L1_A031.R1.clean.fastq.gz -S $data_dir/Pe350upR1-3.sam	2>Pe350upR1-3.log
hisat2 -p 5 -x $reference -U Pe700dnR1-1_L1_A010.R1.clean.fastq.gz -S $data_dir/Pe700dnR1-1.sam	2>Pe700dnR1-1.log
hisat2 -p 5 -x $reference -U Pe700dnR1-2_L1_7917.R1.clean.fastq.gz -S $data_dir/Pe700dnR1-2.sam	2>Pe700dnR1-2.log
hisat2 -p 5 -x $reference -U Pe700dnR1-3_L1_7918.R1.clean.fastq.gz -S $data_dir/Pe700dnR1-3.sam	2>Pe700dnR1-3.log
hisat2 -p 5 -x $reference -U Pe700mdR1-1_L1_A009.R1.clean.fastq.gz -S $data_dir/Pe700mdR1-1.sam	2>Pe700mdR1-1.log
hisat2 -p 5 -x $reference -U Pe700mdR1-2_L1_7915.R1.clean.fastq.gz -S $data_dir/Pe700mdR1-2.sam	2>Pe700mdR1-2.log
hisat2 -p 5 -x $reference -U Pe700mdR1-3_L1_7916.R1.clean.fastq.gz -S $data_dir/Pe700mdR1-3.sam	2>Pe700mdR1-3.log
hisat2 -p 5 -x $reference -U Pe700upR1-1_L1_A008.R1.clean.fastq.gz -S $data_dir/Pe700upR1-1.sam	2>Pe700upR1-1.log
hisat2 -p 5 -x $reference -U Pe700upR1-2_L1_7914.R1.clean.fastq.gz -S $data_dir/Pe700upR1-2.sam	2>Pe700upR1-2.log
hisat2 -p 5 -x $reference -U Pe700upR1-3_L1_7041.R1.clean.fastq.gz -S $data_dir/Pe700upR1-3.sam	2>Pe700upR1-3.log
hisat2 -p 5 -x $reference -U rdPe1200dnR1-1_L1_A021.R1.clean.fastq.gz -S $data_dir/rdPe1200dnR1-1.sam 2>rdPe1200dnR1-1.log
