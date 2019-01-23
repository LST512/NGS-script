#!/bin/bash
#lst
#2018-5-7
#%%.去掉第一个.以及后面的内容
#%.去掉最后一个.以及后面的内容
date
echo "正在将sam转换为bam..."
ls *.sam|while read id ; do (samtools view -bS -@ 6 ${id%.*}.sam > ${id%%.*}.bam) ; done
echo "正在将bam进行sort..."
ls *.bam|while read id ; do (samtools sort -l -9 -m 50M -o ${id%%.*}.bam_sorted -T ${id%%.*} -@ 2 ${id%%.*}.bam) ; done
echo "正在将sort后的bam转为bedgraph"
ls *.bam_sorted|while read id ; do (genomeCoverageBed -bg -ibam ${id%%.*}.bam_sorted -g /home/polya/data/genome/P_ChromSizes.txt -split > ${id%%.*}.bedgraph) ; done
echo "所有操作已完成"
date
