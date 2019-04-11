#
QNAME：测序的reads的名字。
FLAG：二进制数字之和，不同数字代表了不同的意义；比如正负链，R1/R2（双端测序的哪一端）等。
RNAME：map到参考基因组后的染色体名称。
POS：1-based 基因组起始位点。
MAPQ：map的质量。
CIGAR：一个数字与字母交替构成的字符串，标记了这段reads不同位置的match情况。不同字母的含义后边介绍。
RNEXT：如果是pair-end测序，这个为mate（另一端中对应的）的read的染色体名称；否则为下一条read的染色体名称。
PNEXT：同上，read对应的起始位点。
TLEN：模板的长度。
SEQ：序列。
QUAL：序列的质量打分（fasta文件中的那个）。
#
NH:i:1 指此条reads比对到几个loci。1代表unique map
HI:i:1 attrbiutes enumerates multiple
AS:i: 后面数值代表得分
nM:i: 后面数值代表错配数目