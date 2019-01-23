#!/bin/bash
# lst @ 2018-05-08
# STAR mapping 
# p_heterocycla
# by lst
#${id%%_*}删除第一个_及其后面的字符串
cd /home/lyma/P_heterocycla/sequence
pwd
star_index=/home/lyma/P_heterocycla/STAR_index
#fastq=/home/lyma/P_heterocycla/sequence
output=/home/lyma/P_heterocycla/STAR_output
echo "star..."
date
ls *.fq|while read id; do echo "process $id" ; (STAR --runThreadN 15 --outSAMtype BAM SortedByCoordinate --genomeDir $star_index --readFilesIn $id --outFileNamePrefix $output/${id%%_*}) ; done
echo "move bam..."
mv *.bam ../STAR_output/bam_files
echo "move final.out..."
mv *.final.out ../STAR_output/log_mapping_results
echo "move others"
mv *.out *.tab ../STAR_output/log_other_results
echo "all done !!!"
date
