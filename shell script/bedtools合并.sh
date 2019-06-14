#!/bin/bash
#lst
#2019-6
#https://bedtools.readthedocs.io/en/latest/content/tools/unionbedg.html

#bedtools unionbedg [OPTIONS] -i FILE1 FILE2 FILE3 ... FILEn
bedtools unionbedg -i 1.bg 2.bg 3.bg
bedtools unionbedg -i 1.bg 2.bg 3.bg -header
bedtools unionbedg -i 1.bg 2.bg 3.bg -header -names WT-1 WT-2 KO-1
bedtools unionbedg -i 1.bg 2.bg 3.bg -empty -g sizes.txt -header
bedtools unionbedg -i 1.bg 2.bg 3.bg -empty -g sizes.txt -header -filler N/A
bedtools unionbedg -i 1.snp.bg 2.snp.bg 3.snp.bg -filler -/-
#
ls *.bedgraph|while read id
do
echo $id
#四舍五入
awk '{print $1"\t"$2"\t"$3"\t"int($4+0.5)}' $id > ${id%.*}_int.bg
done

#重复样品reads组合为一个文件
bedtools unionbedg -i AN_10d_1-_nor_int.bg AN_10d_2-_nor_int.bg AN_10d_3-_nor_int.bg > AN_10d-_nor_int.bg
bedtools unionbedg -i AN_10d_1+_nor_int.bg AN_10d_2+_nor_int.bg AN_10d_3+_nor_int.bg > AN_10d+_nor_int.bg
bedtools unionbedg -i col_10d_1-_nor_int.bg col_10d_2-_nor_int.bg col_10d_3-_nor_int.bg > col_10d-_nor_int.bg 
bedtools unionbedg -i col_10d_1+_nor_int.bg col_10d_2+_nor_int.bg col_10d_3+_nor_int.bg > col_10d+_nor_int.bg

#合并ssa三个样本的reads
ls *.bg|while read id
do
awk '{$4=$4+$5+$6;print $1"\t"$2"\t"$3"\t"$4}' $id > ${id%_*}.bedgraph 
done





