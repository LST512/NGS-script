#!/bin/bash
date

echo "start........"
echo "##############################\n"

if [$1 != "" ];then
    git add --all && git commit -m "$1" && git push origin master
else
    git add --all && git commit -m "add content" && git push origin master
fi
echo "##############################\n"
echo "ok..........."

date
