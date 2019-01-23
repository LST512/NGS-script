#!/bin/bash
# lst @ 2018-05-30
# homer用法
# 官网http://homer.ucsd.edu/homer/introduction/install.html
'''
1.install
'''
#需要联网安装，之后添加全局变量
perl configureHomer.pl -install
#Downloading Homer Packages
#The basic Homer installation does not contain any sequence data
#perl configureHomer.pl -list 查看支持的物种序列数据
findMotifs.pl unigene_switch.c0Xc800.FU.long.genepac.fasta tair ./results -fasta spartina-final_order_isoforms.fasta

