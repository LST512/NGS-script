#!/bin/bash
for ((i=1;i<=9;i++))
do
  for ((j=1;j<=i;j++))
  do

  echo -ne "$i*$j=$((i*j))\t"
  done
echo
done

