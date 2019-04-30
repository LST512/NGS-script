#!/bin/bash
#cat 文件合并需要注意的问题
'''
合并多个fa文件，如果每个fa文件最后没有空行。
会产生 
>a
atcg>b
atcg
这种格式。
解决办法是手动在末尾添加一个空行
可以用echo -e "\n" >> file.txt
或者echo -e "" >> file.txt
ls *.fa|while read id;do;echo -e "\n" >> ${id%.*}_modify.fa;done
cat *_modify.fa >> total.fa
'''