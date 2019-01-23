#!/bin/bash
#Glycine_max index build by STAR
#date:2018-4-9 by lst
index_dir=/home/polya/data/Glycine_max
fasta_dir=/home/polya/glycine_max/Glycine_max_v2.0.38_ensemble.fa
gtf_dir=/home/polya/glycine_max/Glycine_max_v2.0.38_ensemble.gtf
STAR --runThreadN 5 --limitGenomeGenerateRAM 10000000000 --runMode genomeGenerate --genomeDir $index_dir --genomeFastaFiles $fasta_dir --sjdbGTFfile $gtf_dir
