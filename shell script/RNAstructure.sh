#!/bin/bash
# lst @ 2018-06-07
# RNA二级结构预测，所用软件RNAstructure
# http://rna.urmc.rochester.edu/Text/ProbKnot.html
# http://rna.urmc.rochester.edu/Text/Thermodynamics.html
###### Predict a Secondary Structure
# RNAstructure Fold Results
# (Predict the lowest free energy structure and a set of low free energy structures for a sequence.)
Fold file.txt --DNA --loop 30 --maximum 20 --percent 10 --temperature 310.15 --window 3
# RNAstructure MaxExpect Results
# (Generate a structure or structures composed of highly probable base pairs. This is an alternative method for structure prediction that may have higher fidelity in structure prediction.)
MaxExpect partition.pfs MaxExpect.ct --DNA --gamma 1 --percent 10 --structures 20 --window 3
# RNAstructure ProbKnot Results
# (Predict a secondary structure of probable base pairs, which might include pseudoknots.)
ProbKnot partition.pfs ProbKnot.ct --DNA --iterations 1 --minimum 3
# RNAstructure partition Results
# (Perform a partition function calculation on a single sequence to calculate base pair probabilities.)
partition all_40a.txt partition.pfs --DNA --temperature 310.15
--------------------------------------------------------------------
pipeline
-------------------------------------------------------------------
#1 一次只能处理一个基因，提取基因id
grep '>' fiverUTR_firstProximal_for_3UTR_switch_unigene.fasta > fa.id
cat fa.id|while read line;do grep -A1 $line fiverUTR_firstProximal_for_3UTR_switch_unigene.fasta > ${line#*>}_long.fa;done
#2 partition
ls *.fa|while read id;do partition $id ${id%.*}.pfs --DNA -t 310.15;done
#3 ProbKnot
ls *.pfs|while read id;do ProbKnot $id ${id%.*}_probknot.ct --DNA --iterations 1 --minimum 3;done
#4 MaxExpect
ls *.pfs|while read id;do MaxExpect $id ${id%.*}_maxexpect.ct --DNA --gamma 1 --percent 10 --structures 20 --window 3;done
#5 draw
ls *.ct|while read id;do draw $id ${id%.*}.pdf;done

