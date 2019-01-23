#!/bin/bash
# lst @ 2019-01-12
# 从官网https://www.genome.jp/kegg/pathway.html获取auxin的相关通路，选择合适的map,参考物种选择拟南芥（如果不选择，点进去也会列出来所有的相关基因，但是会比较麻烦）
# 总的：https://www.genome.jp/kegg-bin/show_pathway?map04075
# 拟南芥的：https://www.genome.jp/kegg-bin/show_pathway?org_name=ath&mapno=04075&mapscale=&show_description=hide
# first step
#wget https://www.genome.jp/kegg-bin/show_pathway?org_name=ath&mapno=04075&mapscale=&show_description=hide -O Ara_PlantHormone.xml
# second step 
#cat Ara_PlantHormone.xml|grep 'title="AT'|awk 'BEGIN{FS="title="}{print $2}'|sed -e "s/\"//g" -e "s/\/>//g"|awk 'BEGIN{RS=","}1'|sed 's/^ //g'|awk '{print $1"\t"$2}' > Plant_hormone_signal_transduction.tsv
dir=$(cd `dirname $0`; pwd)
wget $1 -O $dir/pathway.xml
cat $dir/pathway.xml|grep 'title="AT'|awk 'BEGIN{FS="title="}{print $2}'|sed -e "s/\"//g" -e "s/\/>//g"|awk 'BEGIN{RS=","}1'|sed 's/^ //g'|awk '{print $1"\t"$2}'
