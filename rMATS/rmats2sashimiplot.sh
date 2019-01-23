#!/bin/bash
# by lst 2018-3-29
bdir=/home/polya/data/tair/STAR_output
events=/home/polya/data/tair/rmats_results
output=/home/polya/data/tair/rmats2sashimiplot_results
rmats2sashimiplot --b1 $bdir/w01Aligned.sortedByCoord.out.bam,$bdir/w02Aligned.sortedByCoord.out.bam,$bdir/w03Aligned.sortedByCoord.out.bam --b2 $bdir/c01Aligned.sortedByCoord.out.bam,$bdir/c02Aligned.sortedByCoord.out.bam,$bdir/c03Aligned.sortedByCoord.out.bam -t SE -e $events/SE.MATS.JC.txt --l1 WT --l2 CRY --exon_s 1 --intron_s 5 -o $output/
