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
---------------------------------------------
#bedtools的getfasta提取序列，需要有bed文件
#https://bedtools.readthedocs.io/en/latest/content/tools/getfasta.html
'''
1. The headers in the input FASTA file must exactly match the chromosome column in the BED file.

2. You can use the UNIX fold command to set the line width of the FASTA output. For example, fold -w 60 will make each line of the FASTA file have at most 60 nucleotides for easy viewing.

3. BED files containing a single region require a newline character at the end of the line, otherwise a blank output file is produced.
'''
bedtools getfasta [OPTIONS] -fi <input FASTA> -bed <BED/GFF/VCF>
getFastaFromBed [OPTIONS] -fi <input FASTA> -bed <BED/GFF/VCF>
-fo	Specify an output file name. By default, output goes to stdout.
-name	Use the “name” column in the BED file for the FASTA headers in the output FASTA file.
-tab	Report extract sequences in a tab-delimited format instead of in FASTA format.
-bedOut	Report extract sequences in a tab-delimited BED format instead of in FASTA format.
-s	Force strandedness. If the feature occupies the antisense strand, the sequence will be reverse complemented. Default: strand information is ignored.
-split	Given BED12 input, extract and concatenate the sequences from the BED “blocks” (e.g., exons)

bedtools getfasta -fi test.fa -bed test.bed
bedtools getfasta -fi test.fa -bed test.bed -fo test.fa.out
bedtools getfasta -fi test.fa -bed test.bed -name
bedtools getfasta -fi test.fa -bed test.bed -name -tab
bedtools getfasta -fi test.fa -bed test.bed -tab
bedtools getfasta -fi test.fa -bed test.bed -s -name