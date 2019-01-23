#!/bin/bash
#STAR mapping
#Glycine_max
#by lst
#date: 2018-4-10
index=/home/polya/data/Glycine_max
output=/home/polya/data/Glycine_max/STAR_output
STAR --runThreadN 6 --outSAMtype BAM SortedByCoordinate --genomeDir $index --readFilesCommand zcat --readFilesIn HN1_1.clean.fq.gz HN1_2.clean.fq.gz --outFileNamePrefix $output/HN1
STAR --runThreadN 6 --outSAMtype BAM SortedByCoordinate --genomeDir $index --readFilesCommand zcat --readFilesIn HN2_1.clean.fq.gz HN2_2.clean.fq.gz --outFileNamePrefix $output/HN2
STAR --runThreadN 6 --outSAMtype BAM SortedByCoordinate --genomeDir $index --readFilesCommand zcat --readFilesIn HN3_1.clean.fq.gz HN3_2.clean.fq.gz --outFileNamePrefix $output/HN3
STAR --runThreadN 6 --outSAMtype BAM SortedByCoordinate --genomeDir $index --readFilesCommand zcat --readFilesIn LN1_1.clean.fq.gz LN1_2.clean.fq.gz --outFileNamePrefix $output/LN1
STAR --runThreadN 6 --outSAMtype BAM SortedByCoordinate --genomeDir $index --readFilesCommand zcat --readFilesIn LN2_1.clean.fq.gz LN2_2.clean.fq.gz --outFileNamePrefix $output/LN2
STAR --runThreadN 6 --outSAMtype BAM SortedByCoordinate --genomeDir $index --readFilesCommand zcat --readFilesIn LN3_1.clean.fq.gz LN3_2.clean.fq.gz --outFileNamePrefix $output/LN3

