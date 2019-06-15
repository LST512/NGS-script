#!/bin/bash
tar -cvf file.tar file1 ..
tar -xvf file.tar -C /path/
#gzip
tar -zcvf file.tgz file1 ..
tar -zxvf file.tgz -C /path/
#bz
tar -jcvf file.tgz file1 ..
tar -jxvf file.tgz -C /path/


