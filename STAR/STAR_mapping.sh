#!/bin/bash
# lst @ 2018-05-04
# STAR mapping 
# p_heterocycla
# by lst
star_index=/home/lyma/P_heterocycla/STAR_index
fastq=/home/lyma/P_heterocycla/sequence
output=/home/lyma/P_heterocycla/STAR_output
STAR --runThreadN 12 --outSAMtype BAM SortedByCoordinate --genomeDir $star_index --readFilesIn $fastq/findTailATPe1200dnR1-3_L1_7924.R1.clean.noTail.fq --outFileNamePrefix $output/Pe1200dnR1
#chinafir
ls *.fq|while read id;do echo $id;STAR --runThreadN 12 --outSAMtype SAM --genomeDir /home/lyma/ChinsesFir/index --readFilesIn $id --outFileNamePrefix /home/lyma/ChinsesFir/sam_files/${id%%_*}_;done
