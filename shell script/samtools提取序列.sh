#建立index,序列除最后一行，每行的长度要保持抑制
samtools faidx input.fa
'''
第一列 NAME   :   序列的名称，只保留“>”后，第一个空白之前的内容；

第二列 LENGTH:   序列的长度， 单位为bp；

第三列 OFFSET :   第一个碱基的偏移量， 从0开始计数，换行符也统计进行；

第四列 LINEBASES : 除了最后一行外， 其他代表序列的行的碱基数， 单位为bp；

第五列 LINEWIDTH : 行宽， 除了最后一行外， 其他代表序列的行的长度， 包括换行符， 在windows系统中换行符为\r\n, 要在序列长度的基础上加2；
'''
#提序列
samtools faidx input.fa chr1 > chr1.fa
samtools faidx input.fa chr1:100-200 > chr1.fa