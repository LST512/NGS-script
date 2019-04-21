#!/bin/bash
#lst
#2019-4-24
#场景
#有一批id命名的pdf文件，根据目的id（csv文件），获取其中的pdf文件，保存到不同的文件夹下

# cat file.csv|awk -F, '{print $1}' > 1.txt
# cat file.csv|awk -F, '{print $2}' > 2.txt
# cat file.csv|awk -F, '{print $3}' > 3.txt
# cat file.csv|awk -F, '{print $4}' > 4.txt
# cat file.csv|awk -F, '{print $5}' > 5.txt
# cat file.csv|awk -F, '{print $6}' > 6.txt
# cat file.csv|awk -F, '{print $7}' > 7.txt
# cat file.csv|awk -F, '{print $8}' > 8.txt
# cat file.csv|awk -F, '{print $9}' > 9.txt
# cat file.csv|awk -F, '{print $10}' > 10.txt
# cat file.csv|awk -F, '{print $11}' > 11.txt
# cat file.csv|awk -F, '{print $12}' > 12.txt

#用cut切分id.csv,将每列保存起来
for i in {1..12}
do
cut -d , -f $i file.csv > $i.txt
done

#for循环嵌套将匹配的id，其pdf文件复制出来
for i in {1..12}
do
sed "/^$/d" ${i}.txt|cat|while read id;do cp /home/lst/Desktop/新建文件夹/all/${id}.pdf /home/lst/Desktop/新建文件夹/second/${i};done
done





