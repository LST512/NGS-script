#!/bin/bash
# by lst @2018-6-25
# pipeline
###############################
# step 1
###############################
# 由转录本经由OrfPredictor.pl获取预测的ORF并获得预测中最长的那个
# http://bioinformatics.ysu.edu/tools/OrfPredictor.html
#（BLASTX 0 both三个参数必须写但是没用）
perl OrfPredictor.pl transport.fasta BLASTX 0 both 1e-5 out
###############################
# step 2
###############################
# 护花米草一个Cluster含有多个不同的isoform,如果要提取特定的cluster，先提取isoform,转化为一列，除去重复行。如果比对所有的isoform，则直接获取转录本所有的id即可。
total_num=`awk -F, '{print NF}' all_trans.txt|sort -nr|head -1`
echo $total_num
awk -F, '{for(i=1;i<="'$total_num'";i++)print $i}' all_trans.txt|sed '/^$/d' >> all_trans_id.txt
#####################################
# step 3 根据all_trans_id.txt提取序列
#####################################
# 用可视化软件tbtools
#####################################
# step 4 local blast
#####################################
makeblastdb -in tair10_aa.fasta -dbtype nucl -out tair10_AAdb
#################################
2018-8-3更新
用-num_alignments 1 参数只显示一条
用-outfmt 5 参数输出xml格式
用tbtools的Blast XML 2 TBtools Table转换为表格(不要用Blast XML 2 Blast+ Table,会产生重复)
blastp -query test.fa -db tair10_AAdb -num_alignments 1 -outfmt 5 -num_threads 4 -out test.xml
#################################
以下内容舍弃
'''
nohup blastp -query transcript_ORF.txt -db tair10_AAdb -num_alignments 0 -num_descriptions 1 -num_threads 4 -out spartina_transcript_blast_tair.txt &
根据blast结果，可以统计query数，查询比对上的，未比对上的id
grep 'Query=' all_trans_orf_to_tair_aa.txt |wc -l
grep 'Query=' all_trans_orf_to_tair_aa.txt|awk '{print $2}' > all_trans_id.txt
grep 'Symbols:' all_trans_orf_to_tair_aa.txt |wc -l
cat all_trans_orf_to_tair_aa.txt|sed '/^$/d'|grep -B2 'No hits found' |grep 'Query'|awk '{print $2}' > no_blast_id.txt
'''
#获取未比对上的id
ls *.txt|while read id
do
echo $id
cat $id|sed '/^$/d'|grep -B2 'No hits found'|grep 'Query'|awk '{print $2}' > ${id%%.*}_noblastid.id
done
# 获取比对上的id
ls *.id|while read id
pipe while> do
pipe while> awk '{print $0}' all_id $id|sort|uniq -u > ${id%_*}.blastid
pipe while> done
# 提取比对上的结果
cat spa2zea_may.blastid|while read line
pipe while> do
pipe while> sed '/^$/d' spa2zea_may.txt|grep -A4 $line|sed -e '/Length/d' -e '/Score/d' -e '/Value/d' -e 's/Query= //g' -e 's/^  //g' >> spa3zea_may.final 
pipe while> done
'''
