#!/bin/bash
#arabidopsis_bluelight APAtrap.2018-3-16 lst
#predictAPA -i Sample1.bedgraph Sample2.bedgraph -g 2 -n 1 1 -u hg19.utr.bed -o output.txt
##c_0h_vs_ccbl
predictAPA -i c_0h_1.bedgraph c_0h_2.bedgraph c_0h_3.bedgraph CCBL1.bedgraph CCBL2.bedgraph CCBL3.bedgraph -g 2 -n 3 3 -u c_0h_vs_ccbl_utr.bed -o c_0h_vs_ccbl_output.txt
#w_0h_vs_c_oh
predictAPA -i w_0h_1.bedgraph w_0h_2.bedgraph w_0h_3.bedgraph c_0h_1.bedgraph c_0h_2.bedgraph c_0h_3.bedgraph -g 2 -n 3 3 -u w_0h_vs_c_0h_utr.bed -o w_0h_vs_c_0h_output.txt
##w_0h_vs_wcbl
predictAPA -i w_0h_1.bedgraph w_0h_2.bedgraph w_0h_3.bedgraph WCBL1.bedgraph WCBL2.bedgraph WCBL3.bedgraph -g 2 -n 3 3 -u w_0h_vs_wcbl_utr.bed -o w_0h_vs_wcbl_output.txt
#wcbl_vs_ccbl
predictAPA -i WCBL1.bedgraph WCBL2.bedgraph WCBL3.bedgraph CCBL1.bedgraph CCBL2.bedgraph CCBL3.bedgraph -g 2 -n 3 3 -u wcbl_vs_ccbl_utr.bed -o wcbl_vs_ccbl_output.txt
