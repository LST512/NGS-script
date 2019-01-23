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
