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