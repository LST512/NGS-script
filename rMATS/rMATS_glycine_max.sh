#!/bin/bash
#AS by rMATS
#glycine_max
#paired
#lst
#date:2018-4-10
rmatdir=/home/polya/data/rMATS/rMATS/rMATS-turbo-Linux-UCS4
bdir=/home/polya/data/Glycine_max/STAR_output
gtf_file=/home/polya/glycine_max/Glycine_max_v2.0.38_ensemble.gtf
outputdir=/home/polya/data/Glycine_max/rMATS_results
python $rmatdir/rmats.py --b1 $bdir/b1.txt --b2 $bdir/b2.txt --gtf $gtf_file --od $outputdir -t paired --nthread 6 --readLength 149 --cstat 0.0001 --libType fr-unstranded
