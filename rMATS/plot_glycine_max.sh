#!/bin/bash
# rmats2sashimiplot from rMATS AS results
# date：2018-4-11
# by lst
bdir=/home/polya/data/Glycine_max/STAR_output
events=/home/polya/data/Glycine_max/rMATS_results
output=/home/polya/data/Glycine_max/rmatsplot_results
rmats2sashimiplot --b1 $bdir/HN1Aligned.sortedByCoord.out.bam,$bdir/HN2Aligned.sortedByCoord.out.bam,$bdir/HN3Aligned.sortedByCoord.out.bam --b2 $bdir/LN1Aligned.sortedByCoord.out.bam,$bdir/LN2Aligned.sortedByCoord.out.bam,$bdir/LN3Aligned.sortedByCoord.out.bam -t RI -e $events/RI.MATS.JC.txt --l1 HN --l2 LN --exon_s 1 --intron_s 5 -o $output/
