#!/bin/bash
date

echo -e "\e[1;31mStart...git.....\e[0m\n"
echo -e "##############################\n"

if [ ! -n $1 ];then
    git add --all && git commit -m "$1" && git push origin master
else
    git add --all && git commit -m "add content" && git push origin master
fi
echo -e "##############################\n"
echo -e "ok.....finish git.....\n"

date
