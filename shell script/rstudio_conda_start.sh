#!/bin/bash
# lst @ 2018-08-24
# start rstudio installed by conda RSTUDIO_WHICH_R
export RSTUDIO_WHICH_R=/home/lst/miniconda3/envs/biosoft/bin/R 
nohup /home/lst/miniconda3/envs/biosoft/bin/rstudio  >/dev/null 2>&1 &
