#!/bin/bash
#by lst 2018-3-29
rmatdir=/home/polya/data/rMATS/rMATS/rMATS-turbo-Linux-UCS4
bdir=/home/polya/data/tair
gtfdir=/home/polya/data/tair
outputdir=/home/polya/data/tair/results
python $rmatdir/rmats.py --b1 $bdir/b1.txt --b2 $bdir/b2.txt --gtf $gtfdir/tair10_ensembl.gtf --od $outputdir -t paired --nthread 6 --readLength 125 --cstat 0.0001 --libType fr-unstranded

