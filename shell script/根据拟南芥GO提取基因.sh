#/bin/bash
#从tair网站下载拟南芥的GO注释文件/home/lst/data/lst_data/AN3661/AN3661_raw_data/GO_gene/ATH_GO_GOSLIM.txt
#提取相关基因与注释
#root
grep -i "root" ATH_GO_GOSLIM.txt|awk 'BEGIN{FS="\t";print "id\tfunc\tpublic"}{print $1"\t"$5"\t"$13}' > root_gene.tsv
#cytokinin
grep -i "cytokinin" ATH_GO_GOSLIM.txt|awk 'BEGIN{FS="\t";print "id\tfunc\tpublic"}{print $1"\t"$5"\t"$13}' > cytokinin_gene.tsv
#auxin
grep -i "auxin" ATH_GO_GOSLIM.txt|awk 'BEGIN{FS="\t";print "id\tfunc\tpublic"}{print $1"\t"$5"\t"$13}' > auxin_gene.tsv
#ethylene
grep -i "ethylene" ATH_GO_GOSLIM.txt|awk 'BEGIN{FS="\t";print "id\tfunc\tpublic"}{print $1"\t"$5"\t"$13}' > ethylene.tsv
#Gibberellin
grep -i "Gibberellin" ATH_GO_GOSLIM.txt|awk 'BEGIN{FS="\t";print "id\tfunc\tpublic"}{print $1"\t"$5"\t"$13}' > Gibberellin.tsv
#Brassinosteroid
grep -i "Brassinosteroid" ATH_GO_GOSLIM.txt|awk 'BEGIN{FS="\t";print "id\tfunc\tpublic"}{print $1"\t"$5"\t"$13}' > Brassinosteroid.tsv
#Abscisic acid
grep -i "Abscisic acid" ATH_GO_GOSLIM.txt|awk 'BEGIN{FS="\t";print "id\tfunc\tpublic"}{print $1"\t"$5"\t"$13}' > Abscisic acid.tsv
#strigolactone
grep -i "strigolactone" ATH_GO_GOSLIM.txt|awk 'BEGIN{FS="\t";print "id\tfunc\tpublic"}{print $1"\t"$5"\t"$13}' > strigolactone.tsv