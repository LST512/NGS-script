#!/bin/bash
#arabidopsis_bluelight APAtrap.2018-3-15 lst
#./identifyDistal3UTR -i Sample1.bedgraph Sample2.bedgraph -m hg19.genemodel.bed -o test.utr.bed
#c_0h_vs_ccbl
identifyDistal3UTR -i c_0h_1.bedgraph c_0h_2.bedgraph c_0h_3.bedgraph CCBL1.bedgraph CCBL2.bedgraph CCBL3.bedgraph -m TAIR10.genes.bed -s TAIR10_gene_symbol.txt -o c_0h_vs_ccbl_utr.bed
#w_0h_vs_wcbl
identifyDistal3UTR -i w_0h_1.bedgraph w_0h_2.bedgraph w_0h_3.bedgraph WCBL1.bedgraph WCBL2.bedgraph WCBL3.bedgraph -m TAIR10.genes.bed -s TAIR10_gene_symbol.txt -o w_0h_vs_wcbl_utr.bed
#w_0h_vs_c_oh
identifyDistal3UTR -i w_0h_1.bedgraph w_0h_2.bedgraph w_0h_3.bedgraph c_0h_1.bedgraph c_0h_2.bedgraph c_0h_3.bedgraph -m TAIR10.genes.bed -s TAIR10_gene_symbol.txt -o w_0h_vs_c_0h_utr.bed
#wcbl_vs_ccbl
identifyDistal3UTR -i WCBL1.bedgraph WCBL2.bedgraph WCBL3.bedgraph CCBL1.bedgraph CCBL2.bedgraph CCBL3.bedgraph -m TAIR10.genes.bed -s TAIR10_gene_symbol.txt -o wcbl_vs_ccbl_utr.bed
