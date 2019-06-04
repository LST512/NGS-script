#!/bin/bash
#lst
#2019-6
# 统计PAC的分布，一列ftr，六列PAT。每列PAT中不为0的数就为该样本的PAC
if [! -f "$2"];then
echo "创建$2"
else
echo "$2已经存在，删除重建(输入Y)?"
rm -i $2
fi

for i in 3UTR 5UTR AMB CDS exon intergenic.igt intergenic.pm intron pseudogenic_exon
do
echo $i
#awk接受shell的变量方法，双引号位于 awk 脚本 '{if($2>0)print $2}' 之外
#cat $1|awk -v FS="\t" "/$i/"'{if($2>0)print $2}'|wc -l
# 使用awk赋值
#sample=$i
#cat $1|awk -v sample="$sample" -v FS="\t" '$0 ~ sample{if($2>0)print $2}'|wc -l
cat $1|awk -v FS="\t" "/$i/"'{if($2>0)print $2}'|wc -l >> $2;echo AN1_$i# >> $2
cat $1|awk -v FS="\t" "/$i/"'{if($3>0)print $3}'|wc -l >> $2;echo AN2_$i# >> $2
cat $1|awk -v FS="\t" "/$i/"'{if($4>0)print $4}'|wc -l >> $2;echo AN3_$i# >> $2
cat $1|awk -v FS="\t" "/$i/"'{if($5>0)print $2}'|wc -l >> $2;echo CK1_$i# >> $2
cat $1|awk -v FS="\t" "/$i/"'{if($6>0)print $3}'|wc -l >> $2;echo CK2_$i# >> $2
cat $1|awk -v FS="\t" "/$i/"'{if($7>0)print $4}'|wc -l >> $2;echo CK3_$i# >> $2
#echo "AN1_$i\nAN2_$i\nAN3_$i\nCK1_$i\nCK2_$i\nCK1_$i\n"
done
awk -v RS="#" '{print $2"\t"$1}' $2 > $2_final.tsv
rm $2