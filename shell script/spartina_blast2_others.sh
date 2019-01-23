#!/bin/bash
# lst @ 2018-06-11
# 从互花米草的转录本中获取ORF，选择最长的ORF，蛋白序列与其他物种的蛋白序列blast
# 提取转录本id，可能有多个isoform，转化为一列
total_num=`awk -F, '{print NF}' all_trans.txt|sort -nr|head -1`
echo $total_num
# for i in `seq 0 $a`;for i in `eval echo {0..$a}`
#awk变量的传递方法 https://blog.csdn.net/rj042/article/details/72860177
awk -F, '{for(i=1;i<="'$total_num'";i++)print $i}' all_trans.txt|sed '/^$/d' >> all_trans_id.txt
#根据基因id提取fasta序列
tbtools
#ORF提取，NCBI的orffinder或者用orfPredicator.pl http://bioinformatics.ysu.edu/tools/OrfPredictor.html
#输出结果已经选取了最长的转录本
perl OrfPredictor.pl all_trans.fasta BLASTX 0 both 1e-5 orf_out
#配套的一个脚本可以提取cds
#local blast
'''
#建立blast本地数据库
makeblastdb -in Spatina.fasta -dbtype nucl -out Spatinadb
makeblastdb -in fipv_aa.fa -dbtype prot -out fipv_aa_db
#比对参数
blastn -query 1.txt -db Spatinadb -out 2.txt
blastp -query aa.txt -db fipv_aa_db -out aa_res.txt
nohup blastp -query transcript_ORF.txt -db tair10_AAdb -num_alignments 1 -out spartina_transcript_blast_tair.txt &
blastp -query seq.fasta -out seq.blast -db dbname -outfmt 6 -evalue 1e-5 -num_descriptions 10 -num_threads 8
nohup blastp -query transcript_ORF.txt -db tair10_AAdb -num_alignments 0 -num_descriptions 1 -num_threads 4 -out spartina_transcript_blast_tair.txt &
#其他参数
blastn -help
blastp -help
-num_descriptions 5	#保留5条，比对到的id
-num_alignments 2	#保留2条,详细的比对情况
-outfmt 7	#显示格式，默认同网络版
-query： 输入文件路径及文件名
-out：输出文件路径及文件名
-db：格式化了的数据库路径及数据库名
-outfmt：输出文件格式，总共有12种格式，6是tabular格式对应BLAST的m8格式
-evalue：设置输出结果的e-value值
-num_threads：线程数
'''
#################################
2018-8-3更新
用-num_alignments 1 参数只显示一条
用-outfmt 5 参数输出xml格式
用tbtools的Blast XML 2 TBtools Table转换为表格,产生唯一最优值
(Blast XML 2 Blast+ Table,会产生所有blast到的)
blastp -query test.fa -db tair10_AAdb -num_alignments 1 -outfmt 5 -num_threads 4 -out test.xml
#################################
以下内容舍弃
'''
nohup blastp -query transcript_ORF.txt -db tair10_AAdb -num_alignments 0 -num_descriptions 1 -num_threads 4 -out spartina_transcript_blast_tair.txt &
#处理blast结果
#查看query的数，90587
grep 'Query=' all_trans_orf_to_tair_aa.txt |wc -l
#查看比对上的数，89096
grep 'Symbols:' all_trans_orf_to_tair_aa.txt |wc -l
#从blast结果得到查询到的数据,先剔除未blast的query id
# ***** No hits found *****,获取没有blast到的结果，先用sed去除空行
#获取总的query id
grep 'Query=' all_trans_orf_to_tair_aa.txt|awk '{print $2}' > all_trans_id.txt
cat all_trans_orf_to_tair_aa.txt|sed '/^$/d'| grep -B2 'No hits found' |grep 'Query'|awk '{print $2}' > no_blast_id.txt
#获取blast到的id
awk '{print $0}' all_trans_id.txt no_blast_id.txt|sort|uniq -u > blast_id.txt
#获取结果,修改输出格式
cat blast_id.txt|while read line
do
	grep -A4 $line all_trans_orf_to_tair_aa.txt|sed -e '/Length/d' -e '/Score/d' -e '/Value/d' -e 's/Query= //g' -e 's/^  //g' >> final_results.txt
done
#获取query id与tair id，func，其他，最后用paste合并
grep 'SALT' spa2glycine_max.final > salt_id
cat spa2glycine_max.final |grep 'Glycine'|awk '{print $1}' > glycine_max_id
cat spa2glycine_max.final |grep 'Glycine'|awk '{print $(NF-1)}' > nf-1
cat spa2glycine_max.final |grep 'Glycine'|awk '{print $NF}' > nf
#cat spa2glycine_max.final |grep 'Glycine'|awk '{$1=null;$NF=null;$(NF-1)=null;print $0}' > func
--------------
cat 1|while read line
do
grep $line Glycine_max.Glycine_max_v2.0.pep.all.fa|awk '{$1=null;$2=null;print $0}' >> func_all
done
--------------
paste -d"\t" salt_id glycine_max_id func NF-1 NF > final.tsv
'''
