samtools faidx genome.fa 
'''
第一列：序列的名称

第二列：序列长度

第三列：第一个碱基的偏移量，从0开始计数

第四列：除了最后一行外，序列中每行的碱基数

第五列：除了最后一行外，序列中每行的长度（包括换行符）
'''
samtools faidx gennome.fa chr1 > chr1.fa
samtools faidx genome.fa chr1:100-200 > chr1_100_200.fa