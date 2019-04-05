#!/bin/bash


date
echo -e "\e[1;31m..Start..git.....\e[0m\n"
echo -e "##############################\n"



if [ ! -n $1 ];then
    echo -e "\e[1;43m No add git_commit content \e[0m\n"
    git add --all && git commit -m "add content" && git push origin master
else
    echo -e "\e[1;41m add git commit content:\e[0m$1\n"
    git add --all && git commit -m "$1" && git push origin master
fi



echo -e "##############################\n"
echo -e "\e[1;32m..ok.....finish git.....\e[1;32m\n"
date
