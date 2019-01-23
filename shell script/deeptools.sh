# deeptools
# normalization of bam file
'''
bamCoverage \
–of bigwig (output format)\
–bs 10 (bin size)\
-e (extend PE to frag size)\
--ignoreDuplicates \
--normalizeUsingRPKM \
-b (input bam)\
-o (output file name)\
-p 24
------------------------
bamCoverage --bam a.bam -o a.SeqDepthNorm.bw \
    --binSize 10
    --normalizeUsing RPGC
    --effectiveGenomeSize 2150570000
    --ignoreForNormalization chrX
    --extendReads
'''
bamCoverage \
–of bigwig \
–bs 10 \
--ignoreDuplicates \
--normalizeUsingRPKM \
-b (input bam)\
-o (output)\
-p 5

bamCoverage --bam Col_10d_3_Aligned_sorted.bam -o col_10d_3.bw --binSize 10 --normalizeUsing RPKM --ignoreDuplicates -p 4



