#!/bin/bash
# lst @ 2018-05-10
# rsem-calculate-expression
# fastq或者bam放在index前
out_dir=/home/polya/bamboo/bamboo_index/rsem/out
index=/home/polya/bamboo/bamboo_index/rsem/index
ls *.fq|while read id ;do echo $id; rsem-calculate-expression -p 4 --bowtie2 --estimate-rspd --append-names --output-genome-bam $id $index/bamboo $out_dir/${id%%_*};done
