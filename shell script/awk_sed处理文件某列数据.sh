#!/bin/bash
# 数据结构如下
# 1.tsv
#chr1 a.igt b.igt c.igt
#chr2 a  b.igt
#chr3 a  b   c.igt
# 现在只对b列处理，去掉igt
#awk '{print $16}' 20.tsv|sed "s/.igt//"|awk -v OFS="\t" 'FNR==NR{a[NR]=$1;next}{$16=a[FNR]}1' - 20.tsv
# 一行命令
awk '{print $2}' 1.tsv|sed "s/.igt//"|awk -v OFS="\t" 'FNR==NR{a[NR]=$1;next}{$2=a[FNR]}1' - 1.tsv

#拆分
awk '{print $２}' $1|sed "s/.igt//" > igt.tsv
awk '{print $2}' 1.tsv|sed "s/.igt//"|awk -v OFS="\t" 'FNR==NR{a[NR]=$1;next}{$2=a[FNR]}1' igt.tsv 1.tsv
rm igt.tsv
#
cat total_an3661_bowtieEnd_PAC.trimigt.txt|awk 'BEGIN{print "gene\t""AN1\t""AN2\t""AN3\t""Col1\t""Col2\t""Col3\t"}{if($12!="AMB")print $16"\t"$5"\t"$6"\t"$7"\t"$8"\t"$9"\t"$10}' > AN3661_gene_raw_counts.txt