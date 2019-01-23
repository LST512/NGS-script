#!/bin/bash
#P_heterocycla index built by STAR
#lst
#2018-5-3
dir=/home/lyma/P_heterocycla
STAR --runThreadN 14 \
--genomeChrBinNbits 13 \
--runMode genomeGenerate \
--genomeDir $dir/STAR_index \
--genomeFastaFiles $dir/P_heterocycla.fa \
--sjdbGTFfile $dir/P_heterocycla_v1.0.genemodel.gff3 \
--sjdbGTFtagExonParentTranscript Parent 
31000000000
40164681770

/home/polya/opt/STAR-2.6.1a/bin/Linux_x86_64/STAR   --runMode genomeGenerate   --runThreadN 6   --genomeDir ./tair10   --genomeFastaFiles tair10.fa      --sjdbGTFfile tair10.gtf   --sjdbOverhang 74

nohup ../biosoft/STAR-2.5.4b/bin/Linux_x86_64/STAR --runThreadN 20 --limitGenomeGenerateRAM 40164681770 --runMode genomeGenerate --genomeDir /home/lyma/ChinsesFir/index --genomeFastaFiles Cunninghamia_lanceolata_V1.fasta --sjdbGTFfile Cunninghamia_lanceolata_V1.gff3 --sjdbGTFtagExonParentTranscript Parent &
