#!/bin/bash
# 用DEseq2计算的总PAC表（global APA产生的）

# AN3661 ==0 && Col0 != 0
cat $1|awk -F, '{if($6==0 && $7==0 && $8==0 && $9 !=0 && $10 !=0 && $11 !=0) print $0}' > col0_spec.csv
cat $1|awk -F, '{if($6==0 && $7==0 && $8==0 && $9 !=0 && $10 !=0 && $11 !=0) print $13","$17","$42}' > col0_spec_plot_input.csv
cat $1|awk -F, '{if($6==0 && $7==0 && $8==0 && $9 !=0 && $10 !=0 && $11 !=0) print $17}'|sort|uniq > col0_spec_gene_list.csv

# AN3661 !=0 && Col0 == 0
cat $1|awk -F, '{if($6!=0 && $7!=0 && $8!=0 && $9==0 && $10==0 && $11==0) print $0}' > AN3661_spec.csv
cat $1|awk -F, '{if($6!=0 && $7!=0 && $8!=0 && $9==0 && $10==0 && $11==0)print $13","$17","$42}' > AN3661_spec_plot_input.csv
cat $1|awk -F, '{if($6!=0 && $7!=0 && $8!=0 && $9==0 && $10==0 && $11==0)print $17}'|sort|uniq  > AN3661_spec_gene_list.csv

# common

cat $1|awk -F, '{if($6+$7+$8!=0 && $9+$10+$11!=0) print $0}' > common_gene.csv
cat $1|awk -F, '{if($6+$7+$8!=0 && $9+$10+$11!=0) print $17}'|sort|uniq > common_gene_list.csv
