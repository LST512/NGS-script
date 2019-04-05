#!/bin/bash


date
echo -e "\e[1;31m..Start..git.....\e[0m\n"
echo -e "##############################\n"



if [ ! -n $1 ];then
    echo "No add git_commit content"
    git add --all && git commit -m "add content" && git push origin master
else
    echo "add git commit content:$1"
    git add --all && git commit -m "$1" && git push origin master
fi



echo -e "##############################\n"
echo -e "\e[1;32m..ok.....finish git.....\e[1;32m\n"
date
