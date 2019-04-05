#!/bin/bash
date

echo -e "start........\n"
echo -e "##############################\n"

if [ ! -n $1 ];then
    git add --all && git commit -m "$1" && git push origin master
else
    git add --all && git commit -m "add content" && git push origin master
fi
echo -e "##############################\n"
echo -e "ok...........\n"

date
