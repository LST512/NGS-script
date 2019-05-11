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
'''
######## 分析流程
#软件下载
# clustalw
wget http://www.clustal.org/download/current/clustalw-2.1.tar.gz
#数据下载，这里以拟南芥为例,在ensemble plant上下载相应文件备用
wget ftp://ftp.ensemblgenomes.org/pub/release-43/plants/fasta/arabidopsis_thaliana/pep/Arabidopsis_thaliana.TAIR10.pep.all.fa.gz
wget ftp://ftp.ensemblgenomes.org/pub/release-43/plants/fasta/arabidopsis_thaliana/cds/Arabidopsis_thaliana.TAIR10.cds.all.fa.gz
wget ftp://ftp.ensemblgenomes.org/pub/release-43/plants/fasta/arabidopsis_thaliana/dna/Arabidopsis_thaliana.TAIR10.dna.toplevel.fa.gz
wget ftp://ftp.ensemblgenomes.org/pub/release-43/plants/gff3/arabidopsis_thaliana/Arabidopsis_thaliana.TAIR10.43.gff3.gz
wget ftp://ftp.ensemblgenomes.org/pub/release-43/plants/gtf/arabidopsis_thaliana/Arabidopsis_thaliana.TAIR10.43.gtf.gz
