#!/bin/bash
#lst
#2019-6
# 统计PAC的分布，一列ftr，六列PAT。每列PAT中不为0的数就为该样本的PAC
# script pac_count_file pacoutfile
#awk -v FS="," -v OFS="\t" '{print $13,$6,$7,$8,$9,$10,$11}' total_AN3661_bowtielocal_PAC_frac.DESeq2.csv > pac_count.tsv
if [ ! -f "$2" ];then
echo "目录下没有$2，自动创建"
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
#bug注意，exon默认会匹配到pseudogenic_exon，所以要用严格的匹配模式
cat $1|awk -v FS="\t" "/\<$i\>/"'{if($2>0)print $2}'|wc -l >> $2;echo AN1_$i# >> $2
cat $1|awk -v FS="\t" "/\<$i\>/"'{if($3>0)print $3}'|wc -l >> $2;echo AN2_$i# >> $2
cat $1|awk -v FS="\t" "/\<$i\>/"'{if($4>0)print $4}'|wc -l >> $2;echo AN3_$i# >> $2
cat $1|awk -v FS="\t" "/\<$i\>/"'{if($5>0)print $2}'|wc -l >> $2;echo CK1_$i# >> $2
cat $1|awk -v FS="\t" "/\<$i\>/"'{if($6>0)print $3}'|wc -l >> $2;echo CK2_$i# >> $2
cat $1|awk -v FS="\t" "/\<$i\>/"'{if($7>0)print $4}'|wc -l >> $2;echo CK3_$i# >> $2
done
#输出结果，两列
awk -v RS="#" '{print $2"\t"$1}' $2 > $2_final.tsv
#修改输出结果
cat $2_final.tsv |awk '{print $1}'|awk -v ORS="\t" '{print $0}' > ftr
echo -e "\n" >> ftr
cat $2_final.tsv |awk '{print $2}'|awk -v ORS="\t" '{print $0}' > ftr_num
echo -e "\n" >> ftr_num
cat ftr ftr_num > $2_final2.tsv
#------------------------------------------------------------
# 还有一种简单的办法
# 用法 script pac_file outputfile
if [ ! -f "$2" ];then
echo "目录下没有$2，自动创建"
else
echo "$2已经存在，删除重建(输入Y)?"
rm -i $2
fi
# 取6列，统计PAC
for num in {2..7}
do
awk -v seq=$num '{if ($seq>0)print $1}' $1|sort|uniq -c|awk '{print $2"\t"$1}' > ${num}.num
done
if [ ! -f "$2" ];then
echo "目录下没有$2，自动创建"
else
echo "$2已经存在，删除重建(输入Y)?"
rm -i $2
fi
# 取6列，统计PAC
for num in {2..7}
do
awk -v seq=$num '{if ($seq>0)print $1}' $1|sort|uniq -c|awk '{print $2"\t"$1}' > ${num}.num
done
paste -d"\t" *.num|awk 'BEGIN{OFS="\t";print "\tAN1\tAN2\tAN3\tCK1\tCK2\tCK3"}{print $1,$2,$4,$6,$8,$10,$12}' > $2
rm *.num
echo "sucess"
rm *.num


