#!/bin/bash
#一次处理很多任务时
#考虑电脑性能或者需求，每次后台只处理5个
#脚本如下

num=0
ls *.txt | while read id
do
    echo $id 
    let num=num+1
    #num=$((num+1))
    #num=`expr $num + 1` #注意有空格
    if [ $((num % 2 )) -eq 0 ];
    then
        #echo "---------------"
        wait
        num=0
    fi
done