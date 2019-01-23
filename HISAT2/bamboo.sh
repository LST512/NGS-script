#!/bin/bash
#毛竹PAS-Seq测序文件处理。2018-3-16
#hisat2处理
refer=/home/polya/bamboo/bamboo_index/hisat2_index/P_heterocycla
data_dir=/home/polya/data/sra-data/bamboo
#22cm mix
hisat2 -p 5 -x $reference -U Pe22mixR1-1_L1_A001.R1.clean.fastq.gz -S $data_dir/Pe22mixR1.sam 2>Pe22mixR1.log
hisat2 -p 5 -x $reference -U Pe22mixR1-2_L1_A022.R1.clean.fastq.gz -S $data_dir/Pe22mixR2.sam 2>Pe22mixR1.log
hisat2 -p 5 -x $reference -U Pe22mixR1-3_L1_7910.R1.clean.fastq.gz -S $data_dir/Pe22mixR1.sam 2>Pe22mixR1.log
