#!/bin/bash
date
echo "start"
if [$1 !=""];then
    git add --all && git commit -m "$1" && git push origin master
else
    git add --all && git commit -m "add content" && git push origin master
fi
echo "end"
date
