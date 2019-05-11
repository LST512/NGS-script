#!/bin/bash
# 基因家族分析
# lst
# 2019-5
'''
#概念
基因家族：在进化过程中，由一个祖先基因通过基因复制产生两个或多个拷贝，从而发生分化而产生的一组基因。可分为直系同源基因和旁系同源基因。
直系同源基因(Orthologs)：不同物种中，从共同祖先基因进化而来的同源基因，通常具有相同或者相似的基因功能。
旁系同源基因(Paralogs)：同一物种中，由基因复制而分离的同源基因，其功能相似或产生功能功能分化。
基因家族的扩张与收缩；基因复制的方式：染色体片段复制、串联复制和反转录子转座等。
#意义
①：辅助基因注释或矫正基因注释
②：为后续基因功能研究做铺垫
③：确定家族中可用的目标基因分支，挖掘新分支
#内容
一、基因家族成员鉴定
①：确定研究的基因家族 ②：家族成员的基本特征确定 ③：基因组序列，CDS序列，gff文件，氨基酸序列等文件 ④：双向blast比对获取可能的成员 ⑤：根据保守结构域进一步筛选
二：基因家族成员的基本分析
①：序列特征分析如分子大小，等电点等 ②：基于motif分析成员序列保守特征和可视化(可以挖掘未知) ③：基于domain分析成员结构域的保守性与可视化(基本为已知)
④：基因结构分析(内含子模式等) ⑤：基因染色体分布情况可视化
三：基因家族成员的进化分析一
①：多序列比对与可视化 ②：进化树构建与可视化 ③：进化水平分析motif模式 ④：进化水平分析donain ⑤：进化水平分析基因结构的变化
四：基因家族成员的进化分析二
①：基因共线性分析的定义与常见算法 ②：物种内的共线性分析 ③：基因家族成员的来源分析 ④：不同物种之间的共线性分析 ⑤：共线性分析结果和可视化
# 思路 链接：https://www.jianshu.com/p/486dd4aba5eb
全基因组的范围内使用hmmersearch和NBS-ARC基因家族的隐马可夫模型进行基因家族的进行初步搜索，接着把质量比较高的基因家族候选基因筛选出来E-value < 1 × 10−20， 然后使用clustalw2对高质量的序列进行多序列比对，多序列比对后，对这些置信的序列进行隐马可夫模型的构建（使用hmmbuild），最后使用该新建的隐马可夫模型，进一步筛选完整的NSB基因家族序列（需再次过滤，找到基因家族的成员数量一般比第一步初步筛选的多）。
'''
######## 分析流程
#软件下载
# clustalw
wget http://www.clustal.org/download/current/clustalw-2.1.tar.gz
conda install clustalw
# hmmer安装
conda install hmmer
# seqtk
conda install seqtk
#数据下载，这里以拟南芥为例,在ensemble plant上下载相应文件备用
wget ftp://ftp.ensemblgenomes.org/pub/release-43/plants/fasta/arabidopsis_thaliana/pep/Arabidopsis_thaliana.TAIR10.pep.all.fa.gz
wget ftp://ftp.ensemblgenomes.org/pub/release-43/plants/fasta/arabidopsis_thaliana/cds/Arabidopsis_thaliana.TAIR10.cds.all.fa.gz
wget ftp://ftp.ensemblgenomes.org/pub/release-43/plants/fasta/arabidopsis_thaliana/dna/Arabidopsis_thaliana.TAIR10.dna.toplevel.fa.gz
wget ftp://ftp.ensemblgenomes.org/pub/release-43/plants/gff3/arabidopsis_thaliana/Arabidopsis_thaliana.TAIR10.43.gff3.gz
wget ftp://ftp.ensemblgenomes.org/pub/release-43/plants/gtf/arabidopsis_thaliana/Arabidopsis_thaliana.TAIR10.43.gtf.gz
# pfam数据库下载隐马尔科夫模型HMM文件，如关键字搜索NAC-->curation&model-->下载HMM文件
# 以NB-ARC（PF00931）为例


#step1 在拟南芥的蛋白数据库里搜索含有NB-ARC结构域的蛋白；hmmsearch
hmmsearch --cut_tc --domtblout NB-ARC.txt NB-ARC.hmm Arabidopsis_thaliana.TAIR10.pep.all.fa
'''
在鉴定基因家族时，常用到的工具是hmmsearch，里面常用的算法有三种。一般我们使用--cut_tc算法对隐马可夫模型进行搜索，tc算法是使用pfam提供的hmm文件中trusted cutoof的值进行筛选，相对比较可靠
--tblout <f>     : save parseable table of per-sequence hits to file <f>
保存每个序列的命中结果的解析表到文件中
--domtblout <f>  : save parseable table of per-domain hits to file <f>
保存每个结构域的命中结果的解析表到文件中
--pfamtblout <f> : save table of hits and domains to file, in Pfam format <f>
保存命中和结构域的表格到文件，Pfam形式
'''
# step2 根据E-value筛选出高质量的NBS-LRR蛋白序列，如选择<1e-20;uniq -d获取重复
grep -v "#" NB-ARC.txt|awk '{if($7<1E-20) print $1}'|sort -u > NB_ARC_filter.id
seqtk subseq Arabidopsis_thaliana.TAIR10.pep.all.fa NB_ARC_filter.id > NB_ARC_filter_id.fa

# step2 另外一种给的方法是截取domain序列，不是基因的所有蛋白序列。
# perl domain_xulie.pl <hmmoutfile> <fa> <OUT> <E-value>
perl ../download/scripts/domain_xulie.pl NB-ARC.txt Arabidopsis_thaliana.TAIR10.pep.all.fa NB-ARC.pep 1e-20

# step3 根据前面得到的序列构建该物种特异的NBS-LRR保守功能域的隐马尔可夫模型。
#①多序列比对，用clustalw
'''
     1. Sequence Input From Disc
     2. Multiple Alignments
     3. Profile / Structure Alignments
     4. Phylogenetic trees
     S. Execute a system command
     H. HELP
     X. EXIT (leave program)
'''
#选择1--->序列名字；
#选择2--->Do complete multiple alignment now Slow/Accurate，可以用默认输出名。xx.aln和xx.dnd
#运行完输入X退出clustalw
#最终生成两个文件NB-ARC.aln；NB-ARC.dnd
#②构建新的模型，更加准确地尽可能预测所有的基因家族成员
hmmbuild new_NB-ARC.hmm NB-ARC.aln

# step4 用构建的新的模型再次搜索
hmmsearch --cut_tc --domtblout new_NB-ARC.txt new_NB-ARC.hmm

#筛选E-value小于0.01的基因id，提取序列。后续motif与进化树分析
grep -v "#" new_NB-ARC.txt|awk '{if($7<1E-2) print $1}'|sort -u > new_NB-ARC_filter.id
seqtk subseq Arabidopsis_thaliana.TAIR10.pep.all.fa new_NB-ARC_filter.id > new_NB_ARC_filter_id.fa

