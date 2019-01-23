#!/bin/bash
# lst @ 2018-05-28
# tail_tools 
# tools for analysing PAT-Seq high-throughput sequencing data.
# https://github.com/Victorian-Bioinformatics-Consortium/tail-tools
# requirements
-----------------------------------------------
安装依赖
bowtie2
samtools
-----------------------------------------------
R安装devtools
sudo apt-get install gfortran
sudo apt-get install build-essential 
sudo apt-get install libxt-dev 
sudo apt-get install libcurl4-openssl-dev
sudo apt-get install libxml++2.6-dev
sudo apt-get install libssl-dev
install.packages("devtools", dependencies = T)
R安装
devtools::install_github("Victorian-Bioinformatics-Consortium/tail-tools", subdir="tail_tools")
devtools::install_github("MonashBioinformaticsPlatform/varistran")
-----------------------------------------------
python安装
sudo pip install nesoni
sudo pip install --upgrade tail-tools
-----------------------------------------------
安装Fitnoise
https://github.com/pfh/fitnoise
sudo apt-get install python-pip python-numpy python-scipy r-base
sudo pip install --upgrade git+git://github.com/Theano/Theano.git
R:
install.packages(c("rPython", "jsonlite"))
source("http://bioconductor.org/biocLite.R")
biocLite("limma")
-----------------------------------------------
'''
step3
'''
#tail-tools make-tt-reference: \
    <output_dir> \
    <sequence_file> \
    <annotations_file>
#下载ensemble plant的genome与gff3文件
tail-tools make-tt-reference: \
    ref \
    tair10.fa \
    tair10.gff3
#
