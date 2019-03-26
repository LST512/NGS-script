#!/bin/bash
# lst @ 2018-04-25
#extrac sequence
#适用于序列为1行
cat /home/lst/Desktop/transport_800long_name.txt|while read line
do
	echo $line
	sed -n "/${line}/,+1 p" /home/lst/Desktop/unigene_switch.c0Xc800.FU.long.genepac.fasta >> 1.txt
done

#blast结果整理,先获得比对结果的id
cat tair_id|while read line
do
	grep -B6 $line spartina_transcript_blast_tair1.txt >> results
done
#序列为多行，用bioawk或者awk先合并为一行，再用grep或者sed提取，awk还原格式
#bioawk
#先用bioawk将id和序列变为一行
awk '{ printf "%s",/^>/ ? $0" ":$0"\n" }' input.fastq > input_format.fastq
awk '/^>/&&NR>1{print "";}{ printf "%s",/^>/ ? $0" ":$0 }' input.fastq > input_format.fastq
bioawk -c fastx '{print ">"$name; print $seq}' input.fastq > input_format.fastq
#用循环提取
cat id.txt|while read id;do;grep $id input_format.fastq|awk '{print $1"\n"$2}';done >> results.fa
cat id.txt|while read id;do;sed -n "/$id/p" input_format.fastq|awk '{print $1"\n"$2}';done >> results.fa
for i in `cat id.txt`
for i in $(cat id.txt)
#bioawk
bioawk -c fastx '{print $name,length($seq)}' input.fa
bioawk -c fastx '{print $name, gc($seq)}' input.fa
bioawk -c fastx '{print ">"$name;print revcomp($seq)}' input.fa
bioawk -c fastx 'length($seq)>100 {print ">"$name;print $seq}' input.fa
bioawk -c fastx '{print ">PREFIX"$name; $seq}' input.fa
bioawk -c fastx '{print ">"$name"|SUFFIX";$seq}' input.fa
bioawk -t -c fastx '{print $name,$seq}' input.fa
bioawk -c fastx '{print ">"$name; print $seq}' input.fastq
bioawk -t -c header '$age > "20" {print $0}' input.txt