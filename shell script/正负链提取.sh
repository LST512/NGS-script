#!/bin/bash
# awk 'BEGIN{sum=0}{sum+=$4}END{print sum}' AN_all_F.bedgraph 
# samtools idxstats AN_all.bam 
# samtools idxstats AN_all.bam|awk 'BEGIN{sum=0}{sum+=$3}END{print sum}'
#input 为bam时，-g命令被忽略（是基因组大小）
#正链
ls *.bam|while read id
do
echo $id
genomeCoverageBed -ibam $id -strand + -bg -g chrNameLength.txt > ${id%A*}F.bedgraph 
done
#负链
ls *.bam|while read id
do
echo $id
genomeCoverageBed -ibam $id -strand - -bg -g chrNameLength.txt > ${id%A*}R.bedgraph 

#整合的bam;正链
ls *.bam|while read id
do
echo $id
genomeCoverageBed -ibam $id -strand + -bg -g chrNameLength.txt > ${id%.*}_F.bedgraph 
done
#整合的bam;负链
ls *.bam|while read id
do
echo $id
genomeCoverageBed -ibam $id -strand - -bg -g chrNameLength.txt > ${id%.*}_R.bedgraph 
done