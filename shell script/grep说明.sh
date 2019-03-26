#grep 用法
#author：lst
#date：2018-4-27
#date: 2019-3-26
-----------------------------------------
-----------------------------------------
#提取序列，id与序列一行
awk '{ printf "%s",/^>/ ? $0" ":$0"\n" }' input.fastq > input_format.fastq
awk '/^>/&&NR>1{print "";}{ printf "%s",/^>/ ? $0" ":$0 }' input.fastq > input_format.fastq
bioawk -c fastx '{print ">"$name; print $seq}' input.fastq > input_format.fastq
#grep、sed提取，awk改格式
cat id.txt|while read id;do;grep $id input_format.fastq|awk '{print $1"\n"$2}';done >> results.fa
cat id.txt|while read id;do;sed -n "/$id/p" input_format.fastq|awk '{print $1"\n"$2}';done >> results.fa
#根据
#下面的命令没问题，有时候遇到不能输出，应该是txt文件格式不对。复制内容粘贴到新的文本里面，可以解决
'''
head -2 id.txt|while read id
do
grep $id all.txt|awk '{print ">"$1"\n"$2}'
done
'''
#####
#如果是for,一行中两个单词间有空格会被识别为两个。while循环不会
'''
#for i in $(cat 00.txt)
for i in `cat 00.txt`
do
echo $i
done
SALT00000017033
Cluster275-001
SALT00000010830_Cluster1229-001
'''
###for的用read line 解决
'''
while read line
do
grep $line all.txt
done < <(head id.txt)
'''
###<( and )
'''
while read line
do
grep $line all.txt
done < id.txt

'''
#特殊符号用转义符
cat Spatina\ NAC.fasta.txt|grep "\-001"
# 统计文本中特定字符的个数
cat arab_tair10.t_gff10_org.CDS.coord.fa|grep -v '>'|grep -o 'A'|wc -l
grep -o "A" file|wc -l
grep -o "ATCG" file|wc -l
# 统计文本中出现特定字符的行数
grep -c "A" file
grep -c "ATCG" file
#打印某个字母并显示行号，w表示精确匹配
grep -wn 'scaffold_21' Glycine_max.Glycine_max_v2.0.dna.chromosome.1.fa

