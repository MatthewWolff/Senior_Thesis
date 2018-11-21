#!/bin/bash
set -e -x
wget http://opengene.org/fastp/fastp && chmod +x fastp && mv fastp files/

tar -xzf /mnt/gluster/mwolff3/2013-05-23-EBPR_filtered.fastq.tgz -C files/ 
files/fastp -i files/2013-05-23-EBPR_filtered.fastq -o files/2013-05-23-EBPR.filtered --cut_by_quality3
rm files/2013-05-23-EBPR* && mv fastp.html postfiltered.html

tar -xzf /mnt/gluster/mwolff3/2013-05-23-EBPR.fastq.tar.gz -C files/
files/fastp -i files/2013-05-23-EBPR.fastq -o files/2013-05-23-EBPR.filtered --cut_by_quality3
rm files/2013-05-23-EBPR* && mv fastp.html prefiltered.html

exit
